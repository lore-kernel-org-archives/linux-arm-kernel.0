From: trblinux@gmail.com (Tushar Behera)
Date: Mon, 30 Jun 2014 21:01:34 +0530
Subject: [PATCH 00/17] ARM: S5P64X0, S5PC100: no more support in mainline
In-Reply-To: <1404163947-3105-1-git-send-email-kgene.kim@samsung.com>
References: <1404163947-3105-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <53B182D6.5050608@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/2014 03:02 AM, Kukjin Kim wrote:
> This series removes S5P64X0 and S5PC100 related codes in mainline,
> because no more user now. And if its supporting is required later,
> it will be done with using device tree.
> 
> [PATCH 01/17] ARM: S5P64X0: no more support S5P6440 and S5P6450 SoCs
> [PATCH 02/17] gpio: samsung: remove s5p64x0 related gpio codes
> [PATCH 03/17] spi: s3c64xx: remove s5p64x0 related spi codes
> [PATCH 04/17] ASoC: samsung: no more support for S5P6440 and S5P6450
> [PATCH 05/17] pwm: samsung: remove s5p64x0 related pwm codes
> [PATCH 06/17] video: fbdev: s3c-fb: remove s5p64x0 related fimd
> [PATCH 07/17] serial: samsung: no more support for S5P6440 and
> [PATCH 08/17] ARM: S5PC100: no more support S5PC100 SoC
> [PATCH 09/17] gpio: samsung: remov s5pc100 related gpio codes
> [PATCH 10/17] spi: s3c64xx: remove s5pc100 related spi codes
> [PATCH 11/17] pwm: samsung: remove s5pc100 related pwm codes
> [PATCH 12/17] serial: samsung: no more support for S5PC100 SoC
> [PATCH 13/17] ata: pata_samsung_cf: removes s5pc100 related ata
> [PATCH 14/17] mtd: onenand: remove s5pc100 related onenand codes
> [PATCH 15/17] video: fbdev: s3c-fb: remove s5pc100 related fimd and
> [PATCH 16/17] [media] exynos4-is: removes s5pc100 related fimc codes
> [PATCH 17/17] ASoC: Samsung: remove s5pc100 related codes
> 

One more reference to S5PC100 can be found at drivers/irqchip/Kconfig.

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 131f185..9f39cc6 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -23,7 +23,6 @@ config ARM_VIC
 config ARM_VIC_NR
        int
        default 4 if ARCH_S5PV210
-       default 3 if ARCH_S5PC100
        default 2
        depends on ARM_VIC
        help

> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Tushar Behera
