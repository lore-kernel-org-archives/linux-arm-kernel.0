From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 4 Jan 2018 20:03:24 +0100
Subject: [PATCH v5 03/12] dt-bindings: display: sun4i-drm: Add LVDS
 properties
In-Reply-To: <1927811.df6406f6u0@jernej-laptop>
References: <cover.e5a47cc96ec5274dd932daa2bde47df073087da9.1513854122.git-series.maxime.ripard@free-electrons.com>
 <ddbde28fe2e4f21412974e4c69fbfe1c5ff9383f.1513854122.git-series.maxime.ripard@free-electrons.com>
 <1927811.df6406f6u0@jernej-laptop>
Message-ID: <20180104190324.zrrsmdamd7ch2qe5@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Dec 30, 2017 at 12:45:19PM +0100, Jernej ?krabec wrote:
> Hi Maxime,
> 
> Dne ?etrtek, 21. december 2017 ob 12:02:29 CET je Maxime Ripard napisal(a):
> > Some clocks and resets supposed to drive the LVDS logic in the display
> > engine have been overlooked when the driver was first introduced.
> > 
> > Add those additional resources to the binding, and we'll deal with the ABI
> > stability in the code.
> > 
> > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt |  9 +++++++-
> > 1 file changed, 9 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt index
> > 50cc72ee1168..1e21cfaac9e2 100644
> > --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > @@ -121,6 +121,15 @@ Required properties:
> >  On SoCs other than the A33 and V3s, there is one more clock required:
> >     - 'tcon-ch1': The clock driving the TCON channel 1
> > 
> > +On SoCs that support LVDS (all SoCs but the A13, H3, H5 and V3s), you
> > +need one more reset line:
> > +   - 'lvds': The reset line driving the LVDS logic
> > +
> > +And on the SoCs newer than the A31 (sun6i and sun8i families), you
> > +need one more clock line:
> > +   - 'lvds-alt': An alternative clock source, separate from the TCON
> > channel 0 +                 clock, that can be used to drive the LVDS clock
> 
> I think this wording is imprecise, since A83T is part of the sun8i family, but 
> from the code (patch 7) and DT changes (patch 9) you do, it doesn't need this 
> property.
> 
> Maybe it would be just easier to enumerate all compatibles which needs this 
> property? 

You're right, but the rest of the document uses the SoC name
instead. In order to remain consistent, I listed the (currently
supported) SoCs that need that property and applied that patch.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180104/024c3533/attachment.sig>
