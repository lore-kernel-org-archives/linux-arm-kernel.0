From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 29 Oct 2018 10:01:00 +0100
Subject: [PATCH v2 13/15] dt-bindings: sun6i-dsi: Add compatible for A64
 DPHY
In-Reply-To: <CAMty3ZC3jXKBVrrCSd0Un+ZNvNKPj4C0WpcpNOYJBK1=vehBQg@mail.gmail.com>
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
 <20181023155035.9101-14-jagan@amarulasolutions.com>
 <20181024180927.ejt7odo23ebzjgfg@flea>
 <CAMty3ZC3jXKBVrrCSd0Un+ZNvNKPj4C0WpcpNOYJBK1=vehBQg@mail.gmail.com>
Message-ID: <20181029090100.h2zzdchyb3ls2hxe@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 25, 2018 at 06:22:51PM +0530, Jagan Teki wrote:
> On Wed, Oct 24, 2018 at 11:39 PM Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> >
> > On Tue, Oct 23, 2018 at 09:20:33PM +0530, Jagan Teki wrote:
> > > The MIPI DSI PHY HDMI controller on Allwinner A64 is similar
> > > on the one on A31.
> > >
> > > Add A64 compatible and append A31 compatible as fallback.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > > Changes for v2:
> > > - new patch
> > >
> > >  Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> > > index 9fa6e7a758ad..704fb31962f2 100644
> > > --- a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> > > +++ b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> > > @@ -36,7 +36,7 @@ D-PHY
> > >
> > >  Required properties:
> > >    - compatible: value must be one of:
> > > -    * allwinner,sun6i-a31-mipi-dphy
> > > +    * "allwinner,sun50i-a64-mipi-dphy", "allwinner,sun6i-a31-mipi-dphy"
> >
> > No. you need both. The A64 MIPI DPHY one needs to be always set with
> > the A31 fallback, but the A31 is also usable on its own.
> 
> Why wouldn't be, because we don't have any difference dphy right?

That's not my point. You removed from the binding documentation that
allwinner,sun6i-a31-mipi-dphy was a valid option on its own. It's not
ok to do so.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181029/221b2ff4/attachment.sig>
