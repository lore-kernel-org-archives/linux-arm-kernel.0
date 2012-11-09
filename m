From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 9 Nov 2012 14:59:22 +0000
Subject: [PATCH 4/6] ASoC: wm8974: add SPI as a possible bus master
In-Reply-To: <20121109145504.GC8598@pengutronix.de>
References: <1352469625-32024-1-git-send-email-s.trumtrar@pengutronix.de>
 <1352469625-32024-5-git-send-email-s.trumtrar@pengutronix.de>
 <20121109143841.GG23807@opensource.wolfsonmicro.com>
 <20121109145504.GC8598@pengutronix.de>
Message-ID: <20121109145921.GJ23807@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 09, 2012 at 03:55:04PM +0100, Steffen Trumtrar wrote:
> On Fri, Nov 09, 2012 at 02:38:42PM +0000, Mark Brown wrote:

> > We should be converting things to regmap if we're going to do this -
> > we're trying to phase out the ASoC-specific I/O and this makes the code
> > simpler anyway as the core will just be able to get the regmap from the
> > struct device without bouncing information around through the private
> > data and so on.

> I wasn't aware of that driver. That sounds way better than the private data stuff.

If you look in mainline there's a bunch of conversions been done
recently, it's fairly mechanical so hopefully they'll show you what
needs doing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121109/643de7df/attachment-0001.sig>
