From: jagan@amarulasolutions.com (Jagan Teki)
Date: Thu, 25 Oct 2018 18:22:51 +0530
Subject: [PATCH v2 13/15] dt-bindings: sun6i-dsi: Add compatible for A64
 DPHY
In-Reply-To: <20181024180927.ejt7odo23ebzjgfg@flea>
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
 <20181023155035.9101-14-jagan@amarulasolutions.com>
 <20181024180927.ejt7odo23ebzjgfg@flea>
Message-ID: <CAMty3ZC3jXKBVrrCSd0Un+ZNvNKPj4C0WpcpNOYJBK1=vehBQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2018 at 11:39 PM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> On Tue, Oct 23, 2018 at 09:20:33PM +0530, Jagan Teki wrote:
> > The MIPI DSI PHY HDMI controller on Allwinner A64 is similar
> > on the one on A31.
> >
> > Add A64 compatible and append A31 compatible as fallback.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> > Changes for v2:
> > - new patch
> >
> >  Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> > index 9fa6e7a758ad..704fb31962f2 100644
> > --- a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> > +++ b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> > @@ -36,7 +36,7 @@ D-PHY
> >
> >  Required properties:
> >    - compatible: value must be one of:
> > -    * allwinner,sun6i-a31-mipi-dphy
> > +    * "allwinner,sun50i-a64-mipi-dphy", "allwinner,sun6i-a31-mipi-dphy"
>
> No. you need both. The A64 MIPI DPHY one needs to be always set with
> the A31 fallback, but the A31 is also usable on its own.

Why wouldn't be, because we don't have any difference dphy right?
