From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 27 Jun 2018 21:50:43 +0200
Subject: [PATCH v3 00/24] Add support for R40 HDMI pipeline
In-Reply-To: <20180627180215.y5kvvdqeriadxwte@flea>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
 <20180627180215.y5kvvdqeriadxwte@flea>
Message-ID: <20180627195043.hfasvppfm2cbudx7@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1;5202;0c
On Wed, Jun 27, 2018 at 08:02:15PM +0200, Maxime Ripard wrote:
> On Mon, Jun 25, 2018 at 02:02:40PM +0200, Jernej Skrabec wrote:
> > This series adds support for R40 HDMI pipeline. It is a bit special
> > than other already supported pipelines because it has additional unit
> > called TCON TOP responsible for relationship configuration between
> > mixers, TCONs and HDMI. Additionally, it has additional gates for DSI
> > and TV TCONs, TV encoder clock settings and pin muxing between LCD
> > and TV encoders.
> > 
> > However, it seems that TCON TOP will become a norm, since newer
> > Allwinner SoCs like H6 also have this unit.
> > 
> > I tested different possible configurations:
> > - mixer0 <> TCON-TV0 <> HDMI
> > - mixer0 <> TCON-TV1 <> HDMI
> > - mixer1 <> TCON-TV0 <> HDMI
> > - mixer1 <> TCON-TV1 <> HDMI
> > 
> > Please review.
> 
> I just applied it. It didn't apply cleanly, so please make sure it
> does next time, or at least state what the dependencies are.

And it didn't compile either, because of the compile error that was
reported to the previous version by kbuild... Those shouldn't be
ignored and simply fixed.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180627/326b3421/attachment.sig>
