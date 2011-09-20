From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 21 Sep 2011 08:53:59 +0900
Subject: [PATCH 4/7] gpio/samsung: Remove useless old Samsung related GPIO
	drivers
In-Reply-To: <20110920234502.GU7781@ponder.secretlab.ca>
References: <1314707249-12241-1-git-send-email-kgene.kim@samsung.com>
	<1314707249-12241-5-git-send-email-kgene.kim@samsung.com>
	<20110920234502.GU7781@ponder.secretlab.ca>
Message-ID: <003b01cc77f0$91e54580$b5afd080$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant Likely wrote:
> 
> On Tue, Aug 30, 2011 at 09:27:26PM +0900, Kukjin Kim wrote:
> > Since gpio-samsung.c can replace old Samsung GPIO drivers,
> > this patch removes them.
> >
> > Cc: Ben Dooks <ben-linux@fluff.org>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> 
> Removing this code before adding the new code means it is not
> bisectable.  I'll squash the two patches together when I pick them
> up..
> 
OK, no problem and would be better to me if you could create some topic
branch for this series. I'd like to merge it to avoid conflicts with Samsung
stuff.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> 
> > ---
> >  arch/arm/plat-samsung/Makefile      |    2 -
> >  arch/arm/plat-samsung/gpio-config.c |  431
-----------------------------
> >  arch/arm/plat-samsung/gpio.c        |  167 ------------
> >  drivers/gpio/Kconfig                |   28 --
> >  drivers/gpio/Makefile               |    9 -
> >  drivers/gpio/gpio-exynos4.c         |  385 --------------------------
> >  drivers/gpio/gpio-plat-samsung.c    |  205 --------------
> >  drivers/gpio/gpio-s3c24xx.c         |  283 -------------------
> >  drivers/gpio/gpio-s3c64xx.c         |  289 --------------------
> >  drivers/gpio/gpio-s5p64x0.c         |  510
-----------------------------------
> >  drivers/gpio/gpio-s5pc100.c         |  354 ------------------------
> >  drivers/gpio/gpio-s5pv210.c         |  287 --------------------
> >  12 files changed, 0 insertions(+), 2950 deletions(-)
> >  delete mode 100644 arch/arm/plat-samsung/gpio-config.c
> >  delete mode 100644 arch/arm/plat-samsung/gpio.c
> >  delete mode 100644 drivers/gpio/gpio-exynos4.c
> >  delete mode 100644 drivers/gpio/gpio-plat-samsung.c
> >  delete mode 100644 drivers/gpio/gpio-s3c24xx.c
> >  delete mode 100644 drivers/gpio/gpio-s3c64xx.c
> >  delete mode 100644 drivers/gpio/gpio-s5p64x0.c
> >  delete mode 100644 drivers/gpio/gpio-s5pc100.c
> >  delete mode 100644 drivers/gpio/gpio-s5pv210.c
> >
