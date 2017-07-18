From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 17 Jul 2017 18:17:13 -0700
Subject: [PATCH v5 1/2] clk: gate: expose clk_gate_ops::is_enabled
In-Reply-To: <cca4fdb9-7150-0259-4a78-b705b76f2986@st.com>
References: <201707150222.ogIMUhKu%fengguang.wu@intel.com>
 <cca4fdb9-7150-0259-4a78-b705b76f2986@st.com>
Message-ID: <20170718011713.GN22780@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/17, Gabriel FERNANDEZ wrote:
> Hi Stephen,
> 
> 
> On 07/14/2017 08:52 PM, kbuild test robot wrote:
> > Hi Gabriel,
> >
> > [auto build test ERROR on clk/clk-next]
> > [also build test ERROR on v4.12 next-20170714]
> > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> >
> > url:    https://github.com/0day-ci/linux/commits/gabriel-fernandez-st-com/clk-stm32h7-Add-stm32h743-clock-driver/20170714-170518
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
> > config: arm-lpc32xx_defconfig (attached as .config)
> > compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
> > reproduce:
> >          wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >          chmod +x ~/bin/make.cross
> >          # save the attached .config to linux build tree
> >          make.cross ARCH=arm
> >
> > All errors (new ones prefixed by >>):
> >
> >>> drivers/clk/nxp/clk-lpc32xx.c:906:12: error: static declaration of 'clk_gate_is_enabled' follows non-static declaration
> >      static int clk_gate_is_enabled(struct clk_hw *hw)
> >                 ^~~~~~~~~~~~~~~~~~~
> >     In file included from drivers/clk/nxp/clk-lpc32xx.c:13:0:
> >     include/linux/clk-provider.h:346:5: note: previous declaration of 'clk_gate_is_enabled' was here
> >      int clk_gate_is_enabled(struct clk_hw *hw);
> >          ^~~~~~~~~~~~~~~~~~~
> >
> > https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
> Rename 'clk_gate_is_enabled' into'__clk_gate_is_enabled' from clk-gate.c 
> file, is it a good solution for you ?
> 
> i could add also EXPORT_SYMBOL_GPL(__clk_gate_is_enabled) if you are ok.

No. We should rename the lpc32xx one to be less generic as it's
in a specific driver. Double underscore usually means internal or
unlocked (and we poorly did it this way for
__clk_mux_determine_rate function already).

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
