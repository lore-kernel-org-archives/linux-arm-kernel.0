From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 4 Jan 2018 18:09:31 +0530
Subject: [PATCH v4 6/7] ARM: davinci: convert to common clock framework
In-Reply-To: <1514763588-31560-7-git-send-email-david@lechnology.com>
References: <1514763588-31560-1-git-send-email-david@lechnology.com>
 <1514763588-31560-7-git-send-email-david@lechnology.com>
Message-ID: <e36250ba-3f76-71d9-206f-475738d19e36@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 January 2018 05:09 AM, David Lechner wrote:
> This converts all of arch/arm/mach-davinci to the common clock framework.
> The clock drivers from clock.c and psc.c have been moved to drivers/clk,
> so these files are removed.
> 
> There is one subtle change in the clock trees. AUX, BPDIV and OSCDIV
> clocks now have "ref_clk" as a parent instead of the PLL clock. These
> clocks are part of the PLL's MMIO block, but they bypass the PLL and
> therefore it makes more sense to have "ref_clk" as their parent since
> "ref_clk" is the input clock of the PLL.
> 
> CONFIG_DAVINCI_RESET_CLOCKS is removed since the common clock frameworks
> takes care of disabling unused clocks.
> 
> Known issue: This breaks CPU frequency scaling on da850.

This functionality needs to be restored as part of this series since we
cannot commit anything with regressions.

> 
> Also, the order of #includes are cleaned up in files while we are touching
> this code.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

This is a pretty huge patch again and I hope it can be broken down.
Ideally one per SoC converted and then the unused code removal.

Thanks,
Sekhar
