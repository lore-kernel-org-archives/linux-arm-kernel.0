From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 18 Oct 2018 18:58:08 +0200
Subject: [PATCH v2] clk: sunxi-ng: enable so-said LDOs for A64 SoC's
 pll-mipi clock
In-Reply-To: <20181018070729.52943-1-icenowy@aosc.io>
References: <20181018070729.52943-1-icenowy@aosc.io>
Message-ID: <20181018165808.f23gfkwlgskzdbfy@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 18, 2018 at 03:07:29PM +0800, Icenowy Zheng wrote:
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

Queued for 4.21, thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
