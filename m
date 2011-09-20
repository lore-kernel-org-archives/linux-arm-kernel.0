From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 20 Sep 2011 17:45:02 -0600
Subject: [PATCH 4/7] gpio/samsung: Remove useless old Samsung related
	GPIO drivers
In-Reply-To: <1314707249-12241-5-git-send-email-kgene.kim@samsung.com>
References: <1314707249-12241-1-git-send-email-kgene.kim@samsung.com>
	<1314707249-12241-5-git-send-email-kgene.kim@samsung.com>
Message-ID: <20110920234502.GU7781@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2011 at 09:27:26PM +0900, Kukjin Kim wrote:
> Since gpio-samsung.c can replace old Samsung GPIO drivers,
> this patch removes them.
> 
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>

Removing this code before adding the new code means it is not
bisectable.  I'll squash the two patches together when I pick them
up..

g.

> ---
>  arch/arm/plat-samsung/Makefile      |    2 -
>  arch/arm/plat-samsung/gpio-config.c |  431 -----------------------------
>  arch/arm/plat-samsung/gpio.c        |  167 ------------
>  drivers/gpio/Kconfig                |   28 --
>  drivers/gpio/Makefile               |    9 -
>  drivers/gpio/gpio-exynos4.c         |  385 --------------------------
>  drivers/gpio/gpio-plat-samsung.c    |  205 --------------
>  drivers/gpio/gpio-s3c24xx.c         |  283 -------------------
>  drivers/gpio/gpio-s3c64xx.c         |  289 --------------------
>  drivers/gpio/gpio-s5p64x0.c         |  510 -----------------------------------
>  drivers/gpio/gpio-s5pc100.c         |  354 ------------------------
>  drivers/gpio/gpio-s5pv210.c         |  287 --------------------
>  12 files changed, 0 insertions(+), 2950 deletions(-)
>  delete mode 100644 arch/arm/plat-samsung/gpio-config.c
>  delete mode 100644 arch/arm/plat-samsung/gpio.c
>  delete mode 100644 drivers/gpio/gpio-exynos4.c
>  delete mode 100644 drivers/gpio/gpio-plat-samsung.c
>  delete mode 100644 drivers/gpio/gpio-s3c24xx.c
>  delete mode 100644 drivers/gpio/gpio-s3c64xx.c
>  delete mode 100644 drivers/gpio/gpio-s5p64x0.c
>  delete mode 100644 drivers/gpio/gpio-s5pc100.c
>  delete mode 100644 drivers/gpio/gpio-s5pv210.c
> 
