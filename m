From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 28 Jun 2018 10:41:46 +0200
Subject: [PATCH v3 00/24] Add support for R40 HDMI pipeline
In-Reply-To: <4275695.oLYl8XEDF6@jernej-laptop>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
 <20180627180215.y5kvvdqeriadxwte@flea>
 <20180627195043.hfasvppfm2cbudx7@flea>
 <4275695.oLYl8XEDF6@jernej-laptop>
Message-ID: <20180628084146.ttqshyiehjj5by3k@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2018 at 10:25:37PM +0200, Jernej ?krabec wrote:
> Dne sreda, 27. junij 2018 ob 21:50:43 CEST je Maxime Ripard napisal(a):
> > 
> > On Wed, Jun 27, 2018 at 08:02:15PM +0200, Maxime Ripard wrote:
> > > On Mon, Jun 25, 2018 at 02:02:40PM +0200, Jernej Skrabec wrote:
> > > > This series adds support for R40 HDMI pipeline. It is a bit special
> > > > than other already supported pipelines because it has additional unit
> > > > called TCON TOP responsible for relationship configuration between
> > > > mixers, TCONs and HDMI. Additionally, it has additional gates for DSI
> > > > and TV TCONs, TV encoder clock settings and pin muxing between LCD
> > > > and TV encoders.
> > > > 
> > > > However, it seems that TCON TOP will become a norm, since newer
> > > > Allwinner SoCs like H6 also have this unit.
> > > > 
> > > > I tested different possible configurations:
> > > > - mixer0 <> TCON-TV0 <> HDMI
> > > > - mixer0 <> TCON-TV1 <> HDMI
> > > > - mixer1 <> TCON-TV0 <> HDMI
> > > > - mixer1 <> TCON-TV1 <> HDMI
> > > > 
> > > > Please review.
> > > 
> > > I just applied it. It didn't apply cleanly, so please make sure it
> > > does next time, or at least state what the dependencies are.
> > 
> > And it didn't compile either, because of the compile error that was
> > reported to the previous version by kbuild... Those shouldn't be
> > ignored and simply fixed.
> 
> Sorry about that. I forgot to rebase and had same linux-next base for all 3 
> versions.
> 
> I actually take a look at that kbuild message, but it just didn't make much 
> sense and it worked for me without issues. Merge conflicts would explain that.

This was happening when the driver is compiled as a module, which is
pointed by the config attached to the kbuild mail. And asking is
definitely encouraged when you're confused about such things, ignoring
it on the other hand, not so much.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180628/305212bf/attachment.sig>
