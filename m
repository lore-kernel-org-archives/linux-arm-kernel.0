From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 25 Jul 2017 17:14:52 -0700
Subject: [PATCH v3 3/9] clk: at91: add audio pll clock drivers
In-Reply-To: <5f6fd25b-8f99-8dec-39b6-0e7677675c24@free-electrons.com>
References: <20170713074927.10882-1-quentin.schulz@free-electrons.com>
 <20170713074927.10882-4-quentin.schulz@free-electrons.com>
 <20170721222029.GO19878@codeaurora.org>
 <5f6fd25b-8f99-8dec-39b6-0e7677675c24@free-electrons.com>
Message-ID: <20170726001452.GD2146@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/25, Quentin Schulz wrote:
> Hi Stephen,
> 
> I forgot to answer one of your questions:
> 
> On 22/07/2017 00:20, Stephen Boyd wrote:
> > On 07/13, Quentin Schulz wrote:
> >> diff --git a/drivers/clk/at91/clk-audio-pll-pad.c b/drivers/clk/at91/clk-audio-pll-pad.c
> >> new file mode 100644
> >> index 000000000000..10dd6d625696
> >> --- /dev/null
> >> +++ b/drivers/clk/at91/clk-audio-pll-pad.c
> [...]
> >> +}
> >> +
> >> +CLK_OF_DECLARE(of_sama5d2_clk_audio_pll_pad_setup,
> >> +	       "atmel,sama5d2-clk-audio-pll-pad",
> >> +	       of_sama5d2_clk_audio_pll_pad_setup);
> > 
> > We can't have a device driver for this?
> > 
> 
> I tried to work on that but the device does not get probed because the
> parent node (pmc) does not register its children. We would need to
> modify the DT to add such a support and break DT compat.
> 
> As we are speaking about getting rid of clk subnodes (c.f. Rob and
> Alexandre answers on the first version of this patch series:
> https://patchwork.kernel.org/patch/9805991/) in favor of a clock
> controller node that would break the DT compat as well, IMHO it would be
> best to break the DT compat as few times as possible and thus, rework
> this driver once we switch to a clock controller node.
> 

Ok. That's fine. Is there work in progress to make a new binding
here?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
