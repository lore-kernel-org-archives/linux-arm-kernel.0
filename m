From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 11 Apr 2012 18:52:23 +0200
Subject: [PATCH] mmc: remove linux/blkdev.h include from host drivers
In-Reply-To: <87ty0qs2fz.fsf@laptop.org>
References: <1334084783-3572-1-git-send-email-mad_soft@inbox.ru>
 <87ty0qs2fz.fsf@laptop.org>
Message-ID: <20120411165223.GP3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 11:39:12AM -0400, Chris Ball wrote:
> Hi Sascha, Wolfram,
> 
> On Tue, Apr 10 2012, Dmitry Artamonow wrote:
> > I've compile tested everything with and without CONFIG_BLOCK enabled,
> > except for imxmmc.c - this driver seems to be long time broken
> > (at least since the removal of mach-imx in 2.6.31 - see commit
> > 1341d34ffc296f98dc84876f35f3151525dc02a2 ) 
> 
> I can confirm that it no longer builds:
> 
> /home/cjb/git/mmc/drivers/mmc/host/imxmmc.c:32:26: fatal error: mach/imx-dma.h: No such file or directory
> 
> Should imxmmc simply be removed from drivers/mmc/host?  Do any of the
> more current i.MX MMC drivers support the same hardware?

It has long been on my todo list to remove this driver. The more recent
i.MX use the mxcmmc driver which is basically the same hardware but
without a bunch of bugs which made the older imxmmc driver unusable on
newer hardware. I can send a patch if you like.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
