From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 30 Mar 2012 22:13:53 +0200
Subject: [PATCH] ARM: davinci: mark spi_board_info arg to da8xx_register_spi
 as const
Message-ID: <1333138433-14637-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No further changes necessary

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-davinci/devices-da8xx.c      |    2 +-
 arch/arm/mach-davinci/include/mach/da8xx.h |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 42dbf3d..d1624a3 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -831,7 +831,7 @@ static struct platform_device da8xx_spi_device[] = {
 	},
 };
 
-int __init da8xx_register_spi(int instance, struct spi_board_info *info,
+int __init da8xx_register_spi(int instance, const struct spi_board_info *info,
 			      unsigned len)
 {
 	int ret;
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index ee3461d..a2f1f27 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -76,7 +76,8 @@ void __init da850_init(void);
 int da830_register_edma(struct edma_rsv_info *rsv);
 int da850_register_edma(struct edma_rsv_info *rsv[2]);
 int da8xx_register_i2c(int instance, struct davinci_i2c_platform_data *pdata);
-int da8xx_register_spi(int instance, struct spi_board_info *info, unsigned len);
+int da8xx_register_spi(int instance,
+		const struct spi_board_info *info, unsigned len);
 int da8xx_register_watchdog(void);
 int da8xx_register_usb20(unsigned mA, unsigned potpgt);
 int da8xx_register_usb11(struct da8xx_ohci_root_hub *pdata);
-- 
1.7.9.5
