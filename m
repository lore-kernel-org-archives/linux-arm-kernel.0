From: jagan@openedev.com (Jagan Teki)
Date: Thu, 4 Oct 2018 18:39:52 +0530
Subject: [linux-sunxi] [PATCH] clk: sunxi-ng: enable so-said LDOs for A64
 SoC's pll-mipi clock
In-Reply-To: <20181002122911.22094-1-icenowy@aosc.io>
References: <20181002122911.22094-1-icenowy@aosc.io>
Message-ID: <9bd28354-28f8-0393-20ff-e935bbc9a62c@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 02 October 2018 05:59 PM, Icenowy Zheng wrote:
> In the user manual of A64 SoC, the bit 22 and 23 of pll-mipi control
> register is called "LDO{1,2}_EN", and according to the BSP source code
> from Allwinner , the LDOs are enabled during the clock's enabling
> process.
> 
> The clock failed to generate output if the two LDOs are not enabled.
> 
> Add the two bits to the clock's gate bits, so that the LDOs are enabled
> when the PLL is enabled.
> 
> Fixes: c6a0637460c2 ("clk: sunxi-ng: Add A64 clocks")
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---

Tested-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
