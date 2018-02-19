From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 19 Feb 2018 21:46:04 +0100
Subject: [PATCH v2 8/8] drm/rockchip: dw_hdmi: add dw-hdmi support for the
 rk3328
In-Reply-To: <20180219202853.eovn6onxtk7p7f4p@rob-hp-laptop>
References: <20180216204158.29839-1-heiko@sntech.de>
 <20180216204158.29839-9-heiko@sntech.de>
 <20180219202853.eovn6onxtk7p7f4p@rob-hp-laptop>
Message-ID: <6129590.ZtzF0TqO4l@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Am Montag, 19. Februar 2018, 21:28:53 CET schrieb Rob Herring:
> On Fri, Feb 16, 2018 at 09:41:58PM +0100, Heiko Stuebner wrote:
> > The rk3328 uses an external hdmi phy from Innosilicon which uses
> > the generic phy framework for access. Add the necessary data
> > and the compatible for it.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >  .../bindings/display/rockchip/dw_hdmi-rockchip.txt |   1 +
> >  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        | 106 +++++++++++++++++++++
> >  2 files changed, 107 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt
> > index 937bfb472e1d..39143424a474 100644
> > --- a/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt
> > +++ b/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt
> > @@ -13,6 +13,7 @@ Required properties:
> >  
> >  - compatible: should be one of the following:
> >  		"rockchip,rk3288-dw-hdmi"
> > +		"rockchip,rk3328-dw-hdmi"
> 
> Is Designware (Synopsys) now Innosilicon?

Nope :-) .

The rk3328 just combines the Designware dw-hdmi with an (external)
hdmi-phy from Innosilicon, where the hdmi-phy otherwise was was
integrated into the hdmi ip-block.
