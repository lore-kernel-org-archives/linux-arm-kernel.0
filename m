From: philippe.retornaz@epfl.ch (=?utf-8?q?Philippe=20R=C3=A9tornaz?=)
Date: Fri, 20 Jan 2012 18:58:23 +0100
Subject: [PATCH 2/3] mx31moboard: Add watchdog support
In-Reply-To: <1327082304-11398-2-git-send-email-philippe.retornaz@epfl.ch>
References: <1327082304-11398-1-git-send-email-philippe.retornaz@epfl.ch>
 <1327082304-11398-2-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <1327082304-11398-3-git-send-email-philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Philippe R?tornaz <philippe.retornaz@epfl.ch>
---
 arch/arm/mach-imx/Kconfig            |    1 +
 arch/arm/mach-imx/mach-mx31moboard.c |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 0e6f1af..98d9fda 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -454,6 +454,7 @@ config MACH_MX31MOBOARD
 	bool "Support mx31moboard platforms (EPFL Mobots group)"
 	select SOC_IMX31
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
+	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_IPU_CORE
diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index f695a31..eb461cc 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -529,6 +529,8 @@ static void __init mx31moboard_init(void)
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 	gpio_led_register_device(-1, &mx31moboard_led_pdata);
 
+	imx31_add_imx2_wdt(NULL);
+
 	imx31_add_imx_uart0(&uart0_pdata);
 	imx31_add_imx_uart4(&uart4_pdata);
 
-- 
1.6.3.3
