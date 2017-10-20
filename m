From: jbrunet@baylibre.com (Jerome Brunet)
Date: Fri, 20 Oct 2017 10:21:12 +0200
Subject: [PATCH] nvmem: meson: use generic compatible
In-Reply-To: <CAL_JsqKV5yGNFXxsPzAgF6_g-bQn8x8ScXVZ=Wgc1=APPL=mMw@mail.gmail.com>
References: <20171012152450.12454-1-jbrunet@baylibre.com>
 <CAFBinCBVNEqTk+NUHz62FetLhYagFb5K+g17P_2Xb7sBUfEmdA@mail.gmail.com>
 <1507923553.30658.10.camel@baylibre.com>
 <20171017205204.t4vfvbc2c5nsrnhm@rob-hp-laptop>
 <1508311867.3957.33.camel@baylibre.com>
 <CAL_JsqKV5yGNFXxsPzAgF6_g-bQn8x8ScXVZ=Wgc1=APPL=mMw@mail.gmail.com>
Message-ID: <1508487672.3616.18.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-10-19 at 16:10 -0500, Rob Herring wrote:
> On Wed, Oct 18, 2017 at 2:31 AM, Jerome Brunet <jbrunet@baylibre.com> wrote:
> > On Tue, 2017-10-17 at 15:52 -0500, Rob Herring wrote:
> > > On Fri, Oct 13, 2017 at 09:39:13PM +0200, Jerome Brunet wrote:
> > > > On Fri, 2017-10-13 at 21:14 +0200, Martin Blumenstingl wrote:
> > > > > Hi Jerome,
> > > > > 
> > > > > On Thu, Oct 12, 2017 at 5:24 PM, Jerome Brunet <jbrunet@baylibre.com>
> > > > > wrote:
> > > > > > The meson efuse driver seems to be compatible with more SoCs than
> > > > > > initially thought. Let's use the most generic compatible he have in
> > > > > > DT instead of the gxbb specific one
> > > > > > 
> > > > > > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > > > > > ---
> > > > > >  Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt | 4 ++--
> > > > > >  drivers/nvmem/meson-efuse.c                               | 2 +-
> > > > > >  2 files changed, 3 insertions(+), 3 deletions(-)
> > > > > > 
> > > > > > diff --git a/Documentation/devicetree/bindings/nvmem/amlogic-
> > > > > > efuse.txt
> > > > > > b/Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt
> > > > > > index fafd85bd67a6..0260524292fe 100644
> > > > > > --- a/Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt
> > > > > > +++ b/Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt
> > > > > > @@ -1,7 +1,7 @@
> > > > > >  = Amlogic eFuse device tree bindings =
> > > > > > 
> > > > > >  Required properties:
> > > > > > -- compatible: should be "amlogic,meson-gxbb-efuse"
> > > > > > +- compatible: should be "amlogic,meson-gx-efuse"
> > > 
> > > Same comment as for the firmware.
> > > 
> > > > > 
> > > > > have you checked with the devicetree maintainers how they want the
> > > > > documentation to look like in this case?
> > > > 
> > > > You mean "Should we put every compatible existing (in DT) in the
> > > > documentation"
> > > > From what I've seen, at least in meson drivers, only the matched ones
> > > > are
> > > > listed.
> > > > 
> > > > That's a good question though.
> > > > We tend to put soc specific compatible "in case"  we need them later on.
> > > > Should
> > > > we document those ?
> > > 
> > > Absolutely.
> > 
> > My understanding is that this documentation is the documentation of the
> > bindings
> > used by the driver.
> 
> No, the binding doc should be sufficient to validate the dts.
> 
> > If I understand your point, we should document bindings (compatible in that
> > case) that are in fact not fact by the driver. This means that if someone
> > refer
> > only to the documentation, he might be surprised by the result.
> 
> How so?

Compatible not matched.
If the compatible is documented, I would expect "a driver" to match on it

If we document every compatible used in DTS, some won't be matched.

IMO, the current way (document the driver - the matched bindings) is easier and
more predictable.

> 
> Rob
