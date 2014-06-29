From: max.schwarz@online.de (Max Schwarz)
Date: Sun, 29 Jun 2014 19:41 +0200
Subject: [PATCH v4 00/13] Clock support for rk3066,rk3188 and rk3288
In-Reply-To: <1808429.dNxms7FR7U@diego>
References: <1808429.dNxms7FR7U@diego>
Message-ID: <20062771.zMCSBLkWar@typ>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On Sunday 22 June 2014 at 22:41:45, Heiko St?bner wrote:
> This series adds a clock driver infrastructure for Rockchip SoCs in
> general and clock-definitions for the RK3188 and RK3288 in particular.
> 
> The previous attempt to define parts separately in the devicetree did
> not really fit with the clock structure, which became apparent with more
> knowledge about the clock tree.
> 
> The whole structure should support Rockchip SoCs at least down to
> the RK28xx (ARM9) which all share a very similar setup of their clock
> controllers in PLL, divider and gate handling as well as the included
> softreset parts.
> 
> A big change is the move from declaring all mux/dividers/gates individually
> to declaring them as composite clock branches, making the code better
> readable and making it possible to keep clocks together in a more natural
> order.
> 
> The changes under drivers/clk apply cleanly to clk-next but the changes
> in arm/boot/dts require patches from arm-soc, so in the unlikely case of
> this making it in before the merge window the dts patches should go
> through arm-soc (or should do so anyway, as they do not directly depend
> on the drivers/clk changes)

Series:

Acked-By: Max Schwarz <max.schwarz@online.de>
Tested-By: Max Schwarz <max.schwarz@online.de>
on Radxa Rock (RK3188).

Cheers,
  Max
