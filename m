From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 7 Dec 2016 16:41:45 +0100
Subject: [PATCH] ARM: dts: armada-{370, xp}: drop "marvell, orion-spi" from
 SPI controllers
In-Reply-To: <87eg1jhi4l.fsf@free-electrons.com>
References: <20161207152109.17545-1-uwe@kleine-koenig.org>
 <87eg1jhi4l.fsf@free-electrons.com>
Message-ID: <20161207154145.yr2iua73xnoyjsse@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Gregory,

On Wed, Dec 07, 2016 at 04:30:02PM +0100, Gregory CLEMENT wrote:
>  On mer., d?c. 07 2016, Uwe Kleine-K?nig <uwe@kleine-koenig.org> wrote:
> 
> > From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> >
> > The SPI controllers on Armada 370 and XP differ from the original Orion
> > SPI controllers (at least) in the configuration of the baud rate. So
> > it's wrong to claim compatibility which results in bogus baud rates.
> 
> Until two years ago with the commits
> df59fa7f4bca9658b75f0f5fee225b3a057475c5 and
> 4dacccfac69494ba70248b134352f299171c41b7
> we used "marvell,orion-spi" compatible on Armada XP and Armada 370
> without any problem.
> 
> The new compatible "marvell,armada-xp-spi" and "marvell,armada-xp-spi"
> allows to have more choice for the baudrate for a given clock but it is
> not true that Armada 370 and Armada XP are not compatible with
> "marvell,orion-spi".

The issue I was faced with that made me create this patch is that in
barebox no special case for 370/XP was active. The result was that a
device that could be operated at 60 MHz only got a clock of 11 MHz and
the driver assumed it configured 41.666 MHz. I didn't check if the same
can happen in the opposite direction (or if there are other important
incompatibilities) but still I'd say this is a bug with my patch being
the obvious fix.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
