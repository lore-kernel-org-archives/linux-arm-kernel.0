From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 22 Feb 2012 10:14:01 +0200
Subject: [PATCH 8/8] ARM: OMAP2+: Limit omap_read/write usage to legacy
 USB drivers
In-Reply-To: <20120221234051.18709.3571.stgit@kaulin.local>
References: <20120221233619.18709.87982.stgit@kaulin.local>
 <20120221234051.18709.3571.stgit@kaulin.local>
Message-ID: <1329898441.2070.10.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-02-21 at 15:40 -0800, Tony Lindgren wrote:
> Drivers should no longer use omap_read/write functions
> but instead use ioremap + read/write functions.
> 
> As some USB legacy code is still shared between omap1 and
> omap2420, let's limit the omap_read/write to plat/usb.h.
> 
> Also, let's make drivers/video/omap/lcdc.c depend on
> ARCH_OMAP1 as it is not needed for omap2+.

I'm ok with the lcdc.c change, but I also have a patch series that makes
the same change, plus removes the omap2 code from drivers/video/omap/.

Can you check the series, and give ack if the arch/arm side looks fine?
It's this one: [PATCH 00/16] OMAPDSS: old OMAPFB cleanup

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120222/ecb60c80/attachment.sig>
