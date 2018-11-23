From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 23 Nov 2018 10:11:45 +0800
Subject: [PATCH v9 1/8] ASoC: dt-bindings: sun50i-codec-analog: Add
 headphone amp regulator supply
In-Reply-To: <20181122154819.powgbwwqpljqvjty@flea>
References: <20181122102325.29495-1-wens@csie.org>
 <20181122102325.29495-2-wens@csie.org>
 <20181122153241.lzrwhkewg5q4hy2c@flea>
 <CAGb2v64-Wszg9m8+jCPWzYYRQduwpod2P0UdrFdhTLvAe3paPA@mail.gmail.com>
 <20181122154819.powgbwwqpljqvjty@flea>
Message-ID: <CAGb2v669eNKvLxrD4OXgqUa_6qXwvNR0241AkS2x_zC3NCSo1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2018 at 11:48 PM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> On Thu, Nov 22, 2018 at 11:41:57PM +0800, Chen-Yu Tsai wrote:
> > On Thu, Nov 22, 2018 at 11:33 PM Maxime Ripard
> > <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Thu, Nov 22, 2018 at 06:23:18PM +0800, Chen-Yu Tsai wrote:
> > > > On the Allwinner A64 SoC, the audio codec has a built-in headphone
> > > > amplifier. This amplifier has a power supply separate from the rest of
> > > > the analog audio circuitry.
> > > >
> > > > Add a regulator supply property to handle this.
> > > >
> > > > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > > > ---
> > > >  Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt b/Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt
> > > > index 4f8ad0e04d20..056a098495cc 100644
> > > > --- a/Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt
> > > > +++ b/Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt
> > > > @@ -4,9 +4,11 @@ Required properties:
> > > >  - compatible: must be one of the following compatibles:
> > > >               - "allwinner,sun50i-a64-codec-analog"
> > > >  - reg: must contain the registers location and length
> > > > +- cpvdd-supply: Regulator supply for the headphone amplifier
> > >
> > > I guess we should make this optional, since even if it's missing, it's
> > > going to create a dummy regulator. and that allows to have backward
> > > compatibility.
> > >
> > > For the rest of the series,
> > > Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> >
> > This one (not sun8i-codec-analog) is new for the next release, so there's
> > no backward compatibility to consider. Plus none of the device tree changes
> > for A64 have been merged.
>
> Ok, that works for me then.

Well, I misspoke. The driver was introduced in 4.20-rc1, and these changes will
end up in 4.21. But again, since we don't have any device tree changes already
merged, we should be fine.

Implementation wise, there really isn't a "required" variant of the regulator
API. The API will use the dummy regulator if it's missing.

ChenYu
