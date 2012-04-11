From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 11 Apr 2012 22:25:43 +0200
Subject: [PATCH] mmc: remove imxmmc driver
In-Reply-To: <87hawqrq3k.fsf@laptop.org>
References: <1334174103-4724-1-git-send-email-s.hauer@pengutronix.de>
 <87hawqrq3k.fsf@laptop.org>
Message-ID: <20120411202543.GQ3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 04:05:51PM -0400, Chris Ball wrote:
> Hi Sascha,
> 
> On Wed, Apr 11 2012, Sascha Hauer wrote:
> > This driver is broken since 2.6.31 when the traditional i.MX1
> > support was removed.
> >
> > In theory the i.MX1 mmc controller can be supported by the mxcmmc
> > driver which basically is the same hardware. However, the i.MX1
> > controller has severe bugs which made several workarounds necessary which
> > resulted in a different driver structure. At that time it seemed easier
> > to write a second driver to support hardware without bugs.
> >
> > As noone cared for the i.MX1 driver for a long time and it does
> > not compile, remove it.
> >
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/mmc/host/Kconfig  |   10 -
> >  drivers/mmc/host/Makefile |    1 -
> >  drivers/mmc/host/imxmmc.c | 1169 ---------------------------------------------
> >  3 files changed, 1180 deletions(-)
> >  delete mode 100644 drivers/mmc/host/imxmmc.c
> 
> Looks good, but you missed drivers/mmc/host/imxmmc.h.

Damned, there was a time when drivers had its own header files ;)
Just resent.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
