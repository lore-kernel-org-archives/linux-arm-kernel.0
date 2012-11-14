From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 14 Nov 2012 15:44:21 +0000 (UTC)
Subject: [PATCH] ARM: OMAP4: hwmod data: ipu and dsp to use parent clocks
 instead of leaf clocks
In-Reply-To: <1352860750-20100-1-git-send-email-omar.luna@linaro.org>
References: <1352860750-20100-1-git-send-email-omar.luna@linaro.org>
Message-ID: <alpine.DEB.2.00.1211141542280.16047@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Tue, 13 Nov 2012, Omar Ramirez Luna wrote:

> This prevents hwmod _enable_clocks...omap2_dflt_clk_enable path
> from enabling modulemode inside CLKCTRL using its clk->enable_reg
> field. Instead is left to _omap4_enable_module though soc_ops, as
> the one in charge of this setting.
> 
> According to comments received[1] for related patches the idea is
> to get rid of leaf clocks in future. So remove these two while at it.
> 
> [1] http://lkml.org/lkml/2012/8/20/226
> 
> Signed-off-by: Omar Ramirez Luna <omar.luna@linaro.org>

Does this one belong as part of the "OMAP: iommu: hwmod, reset 
handling and runtime PM" series?  Looks like applying this one separately 
might cause these clocks not to be disabled by either the clock code's 
disable-unused-clocks code, or the hwmod code?


- Paul
