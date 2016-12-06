From: broonie@kernel.org (Mark Brown)
Date: Tue, 6 Dec 2016 11:13:53 +0000
Subject: [PATCH 8/9] mfd: wm97xx-core: core support for wm97xx Codec
In-Reply-To: <87y406ppjl.fsf@belgarion.home>
References: <1477510907-23495-1-git-send-email-robert.jarzmik@free.fr>
 <1477510907-23495-9-git-send-email-robert.jarzmik@free.fr>
 <20161118165040.GB19884@dell.home> <87twb3r94s.fsf@belgarion.home>
 <20161121101219.GB32509@dell> <87y406ppjl.fsf@belgarion.home>
Message-ID: <20161206111353.fq5445yuzsy7li4i@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 26, 2016 at 10:18:38AM +0100, Robert Jarzmik wrote:

> >> >> +#define WM9705_VENDOR_ID 0x574d4c05
> >> >> +#define WM9712_VENDOR_ID 0x574d4c12
> >> >> +#define WM9713_VENDOR_ID 0x574d4c13
> >> >> +#define WM97xx_VENDOR_ID_MASK 0xffffffff

> >> > These are probably better represented as enums.
> >> These are ids, just as devicetree ids, or PCI ids, I don't think an enum will
> >> fit.

> > That's fine.  We can use enums to simply group items of a similar
> > type.  Representing these as enums would only serve to benefit code
> > cleanliness.  What makes you think they won't fit?

That would be like having all PCI or USB identifiers in an enum, it's
doable but it means having one big table that all drivers need to
modify.

> >> >> +static int wm97xx_ac97_probe(struct ac97_codec_device *adev)

> >> As for the "sound specific part", it's because AC97 bus is mainly used in sound
> >> oriented drivers, but still the codec IPs provide more than just sound, as the
> >> Wolfson codecs for instance.

> > I'd like to get Mark Brown's opinion on this.

I'm not sure what the question is, sorry.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161206/bb87a688/attachment.sig>
