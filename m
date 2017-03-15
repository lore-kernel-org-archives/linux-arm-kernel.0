From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 15 Mar 2017 11:10:54 +0100
Subject: [PATCH 1/3] dt-bindings: add the grf clock for dw-mipi-dsi
In-Reply-To: <58C90F8B.7070102@rock-chips.com>
References: <1489567352-3333-1-git-send-email-zyw@rock-chips.com>
 <3304582.Whtjx7Nypf@diego> <58C90F8B.7070102@rock-chips.com>
Message-ID: <2439695.Eb3n5AH02E@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 15. M?rz 2017, 17:55:23 CET schrieb Chris Zhong:
> Hi Heiko
> 
> On 03/15/2017 05:03 PM, Heiko St?bner wrote:
> > Am Mittwoch, 15. M?rz 2017, 16:42:30 CET schrieb Chris Zhong:
> >> For RK3399, the grf clock should be controlled by dw-mipi-dsi driver,
> >> add the description for this clock.
> >> 
> >> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> >> ---
> >> 
> >>   .../devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt      
> >>   | 2
> >> 
> >> +- 1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git
> >> a/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip
> >> .t
> >> xt
> >> b/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip
> >> .t
> >> xt index 188f6f7..7e17a60 100644
> >> ---
> >> a/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip
> >> .t
> >> xt +++
> >> b/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip
> >> .t
> >> 
> >> xt @@ -10,7 +10,7 @@ Required properties:
> >>   - interrupts: Represent the controller's interrupt to the CPU(s).
> >>   - clocks, clock-names: Phandles to the controller's pll reference
> >>   
> >>     clock(ref) and APB clock(pclk). For RK3399, a phy config clock
> >> 
> >> -  (phy_cfg) is additional required. As described in [1].
> >> +  (phy_cfg) and a grf clock(grf) are additional required. As described
> >> in
> >> [1].
> > 
> > your "grf" clock is optional, as it is not present on all socs (like the
> > rk3288) so should probably move to a separate section and not be in the
> > required properties
> 
> For RK3399, the grf clock is required, according to the advice provided
> by rob[0],
> put it into "required properties " is better.
> [0] https://patchwork.kernel.org/patch/9220187/

ok, but it should probably be made clear, that this is rk3399-specific
