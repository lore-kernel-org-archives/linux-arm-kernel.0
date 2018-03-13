From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 13 Mar 2018 09:23:37 +0100
Subject: [PATCH v2 4/6] ASoC: sun4i-i2s: Add multi-lane functionality
In-Reply-To: <CAEKpxBkE_Aipa3Z6r0HnVNuU-kmfr1zandotZzQ9Z0AkShR=rw@mail.gmail.com>
References: <20180312155753.9478-1-codekipper@gmail.com>
 <20180312155753.9478-5-codekipper@gmail.com>
 <20180313080026.jtag4w46koxzeqe2@flea>
 <CAEKpxBkE_Aipa3Z6r0HnVNuU-kmfr1zandotZzQ9Z0AkShR=rw@mail.gmail.com>
Message-ID: <20180313082337.zekrzyx5utx5lkj6@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2018 at 09:15:49AM +0100, Code Kipper wrote:
> On 13 March 2018 at 09:00, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > On Mon, Mar 12, 2018 at 04:57:51PM +0100, codekipper at gmail.com wrote:
> >> From: Marcus Cooper <codekipper@gmail.com>
> >>
> >> The i2s block supports multi-lane i2s output however this functionality
> >> is only possible in earlier SoCs where the pins are exposed and for
> >> the i2s block used for HDMI audio on the later SoCs.
> >>
> >> To enable this functionality, an optional property has been added to
> >> the bindings.
> >>
> >> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> >> ---
> >>  .../devicetree/bindings/sound/sun4i-i2s.txt        |  3 ++
> >>  sound/soc/sunxi/sun4i-i2s.c                        | 48 +++++++++++++++++-----
> >>  2 files changed, 41 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> >> index 48addef65b8f..3f966ac61b9e 100644
> >> --- a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> >> +++ b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> >> @@ -33,6 +33,9 @@ Optional properties:
> >>                               configured to extend the slot width to the
> >>                               value specified. Min 8, Max 32.
> >>
> >> +- allwinner,playback-channels:  if this property is present then the number
> >> +                             of available channels is extended and the
> >> +                             outputs enabled.
> >
> > Isn't it something that is fixed for each generation of SoCs? Can't we
> > attach it to the compatible?
> 
> I'm not sure as the documentation is pretty poor. It looks like it is
> supported by all of the variations that we've seen but only exposed as
> pins on A10 and A20. I'm also not sure who would ever use it with
> external devices.

Well, you were saying that it was the case on the older SoCs in your
commit log, so this needs to be figured out.

> The reason why I've added it is that it is required by HDMI for
> supporting surround sound on the newer SoCs.

Why isn't that mentionned in your commit log?

Can you post the whole set of changes needed for HDMI audio? this
would make things much easier to see where you're going.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180313/dbfdf361/attachment.sig>
