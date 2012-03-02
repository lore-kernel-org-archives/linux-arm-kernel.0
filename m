From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri,  2 Mar 2012 11:07:35 +0100
Subject: [PATCH 2/2] ARM: versatile: add some auxdata for device trees
Message-ID: <1330682855-21199-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MMCI and PL022 SPI drivers sure need their platform data to
work on the Versatile as well. (This does not fix the auxdata for
MMCI instance mmc1 on the Versatile PB though.)

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Niklas Hernaeus <niklas.hernaeus@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-versatile/core.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 02b7b93..d72c8ad 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -664,17 +664,18 @@ static struct amba_device *amba_devs[] __initdata = {
  * having a specific name.
  */
 struct of_dev_auxdata versatile_auxdata_lookup[] __initdata = {
-	OF_DEV_AUXDATA("arm,primecell", VERSATILE_MMCI0_BASE, "fpga:05", NULL),
+	OF_DEV_AUXDATA("arm,primecell", VERSATILE_MMCI0_BASE, "fpga:05", &mmc0_plat_data),
 	OF_DEV_AUXDATA("arm,primecell", VERSATILE_KMI0_BASE, "fpga:06", NULL),
 	OF_DEV_AUXDATA("arm,primecell", VERSATILE_KMI1_BASE, "fpga:07", NULL),
 	OF_DEV_AUXDATA("arm,primecell", VERSATILE_UART3_BASE, "fpga:09", NULL),
+	/* FIXME: this is buggy, the platform data is needed for this MMC instance too */
 	OF_DEV_AUXDATA("arm,primecell", VERSATILE_MMCI1_BASE, "fpga:0b", NULL),
 
 	OF_DEV_AUXDATA("arm,primecell", VERSATILE_CLCD_BASE, "dev:20", &clcd_plat_data),
 	OF_DEV_AUXDATA("arm,primecell", VERSATILE_UART0_BASE, "dev:f1", NULL),
 	OF_DEV_AUXDATA("arm,primecell", VERSATILE_UART1_BASE, "dev:f2", NULL),
 	OF_DEV_AUXDATA("arm,primecell", VERSATILE_UART2_BASE, "dev:f3", NULL),
-	OF_DEV_AUXDATA("arm,primecell", VERSATILE_SSP_BASE, "dev:f4", NULL),
+	OF_DEV_AUXDATA("arm,primecell", VERSATILE_SSP_BASE, "dev:f4", &ssp0_plat_data),
 
 #if 0
 	/*
-- 
1.7.7.6
