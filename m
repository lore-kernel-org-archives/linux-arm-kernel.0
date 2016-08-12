From: robh@kernel.org (Rob Herring)
Date: Fri, 12 Aug 2016 13:37:32 -0500
Subject: [PATCH 1/3] net: stmmac: dwmac-rk: add rk3366 & rk3399 specific
 data
In-Reply-To: <1799606.7CVTQCi7m5@diego>
References: <1470900288-10109-1-git-send-email-roger.chen@rock-chips.com>
 <1470900288-10109-2-git-send-email-roger.chen@rock-chips.com>
 <1799606.7CVTQCi7m5@diego>
Message-ID: <20160812183732.GA3838@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 11, 2016 at 10:12:44AM +0200, Heiko St?bner wrote:
> Hi Roger,
> 
> Am Donnerstag, 11. August 2016, 15:24:46 schrieb Roger Chen:
> > Add constants and callback functions for the dwmac on rk3228/rk3229 socs.
> > As can be seen, the base structure is the same, only registers and the
> > bits in them moved slightly.
> > 
> > Signed-off-by: Roger Chen <roger.chen@rock-chips.com>
> > ---
> >  .../devicetree/bindings/net/rockchip-dwmac.txt     |   4 +-
> >  drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     | 226
> > +++++++++++++++++++++ 2 files changed, 228 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.txt
> > b/Documentation/devicetree/bindings/net/rockchip-dwmac.txt index
> > cccd945..8c066e6 100644
> > --- a/Documentation/devicetree/bindings/net/rockchip-dwmac.txt
> > +++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.txt
> > @@ -3,8 +3,8 @@ Rockchip SoC RK3288 10/100/1000 Ethernet driver(GMAC)
> >  The device node has following properties.
> > 
> >  Required properties:
> > - - compatible: Can be one of "rockchip,rk3228-gmac",
> > "rockchip,rk3288-gmac", -                            
> > "rockchip,rk3368-gmac"
> > + - compatible: Can be one of "rockchip,rk3288-gmac",
> 
> you're dropping the rk3228 here.

And please do 1 compatible per line unless multiple strings apply to a 
given platform.

Rob
