From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 06 May 2011 13:15:27 +0900
Subject: [PATCH] leds: drop leds-h1940 driver
In-Reply-To: <1303912597-32653-1-git-send-email-anarsoul@gmail.com>
References: <1303912597-32653-1-git-send-email-anarsoul@gmail.com>
Message-ID: <00f701cc0ba4$3cb4b680$b61e2380$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vasily Khoruzhick wrote:
> 
> H1940 machine now uses leds-gpio and leds-h1940 has no users anymore. So
> drop it.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  drivers/leds/Kconfig      |    7 --
>  drivers/leds/Makefile     |    1 -
>  drivers/leds/leds-h1940.c |  170
-------------------------------------------
> --
>  3 files changed, 0 insertions(+), 178 deletions(-)
>  delete mode 100644 drivers/leds/leds-h1940.c
> 
Hi Vasily,

Hmm, regarding maintainer who is Richard Purdie(LED) in this case should be
added in Cc. (Cc'ed him)

And I think need following with this patch.

--- a/arch/arm/configs/s3c2410_defconfig
+++ b/arch/arm/configs/s3c2410_defconfig
@@ -389,7 +389,6 @@ CONFIG_MMC_SPI=m
 CONFIG_MMC_S3C=y
 CONFIG_LEDS_CLASS=m
 CONFIG_LEDS_S3C24XX=m
-CONFIG_LEDS_H1940=m
 CONFIG_LEDS_PCA9532=m
 CONFIG_LEDS_GPIO=m
 CONFIG_LEDS_PCA955X=m


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
