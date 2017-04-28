From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Fri, 28 Apr 2017 14:05:29 +0200
Subject: [PATCH v2] clk: sunxi-ng: Fix dependency on SUNXI_CCU_GATE
In-Reply-To: <20170428011533.GZ7065@codeaurora.org>
References: <20170426115319.30951-1-clabbe.montjoie@gmail.com>
 <20170427070436.3qu4mzepq4gmmymi@lukather>
 <20170427081249.GA25781@Red> <20170428011533.GZ7065@codeaurora.org>
Message-ID: <20170428120529.GA25131@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 27, 2017 at 06:15:33PM -0700, Stephen Boyd wrote:
> On 04/27, Corentin Labbe wrote:
> > On Thu, Apr 27, 2017 at 09:04:36AM +0200, Maxime Ripard wrote:
> > > On Wed, Apr 26, 2017 at 01:53:19PM +0200, Corentin Labbe wrote:
> > > > When CONFIG_SUNXI_CCU is set but no other SUNXI_CCU is selected i got
> > > > the following build error:
> > > > drivers/built-in.o: In function `ccu_pll_notifier_cb':
> > > > drivers/clk/sunxi-ng/ccu_common.c:71: undefined reference to `ccu_gate_helper_disable'
> > > > drivers/clk/sunxi-ng/ccu_common.c:73: undefined reference to `ccu_gate_helper_enable'
> > > > 
> > > > The problem is the function ccu_pll_notifier_cb in ccu_common.c need
> > > > some function from ccu_gate.c which is not compiled since SUNXI_CCU_GATE
> > > > is not selected.
> > > > 
> > > > This patch remove SUNXI_CCU_GATE and compile ccu_gate.c unconditionnaly
> > > > since all other combination of options select SUNXI_CCU_GATE finally.
> > > > 
> > > > Fixes: 02ae2bc6febd ("clk: sunxi-ng: Add clk notifier to gate then ungate PLL clocks")
> > > > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> > > 
> > > I think Chen-Yu had some comments that you didn't address.
> > > 
> > 
> > I have changed subject as requested
> 
> There were more comments than just fixing the subject. And now
> Arnd has sent a patch. This is a problem in mainline, and the
> release is days away. I'm inclined to go with Arnd's patch unless
> someone sends something else and forward it directly to Linus.

Sorry, I havent see the rest of wens's comments.
Go for Arnd's patch.
