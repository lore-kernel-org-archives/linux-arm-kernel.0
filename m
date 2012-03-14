From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 14 Mar 2012 13:04:57 +0000
Subject: [PATCH 01/10] ARM: ux500: CONFIG: Enable Device Tree support for
 future endeavours
In-Reply-To: <1331730306-11461-1-git-send-email-lee.jones@linaro.org>
References: <1331730306-11461-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1331730306-11461-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/u8500_defconfig |    1 +
 arch/arm/mach-ux500/Kconfig      |    6 ++++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index 2d7b6e7..889d73a 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -13,6 +13,7 @@ CONFIG_UX500_SOC_DB8500=y
 CONFIG_MACH_HREFV60=y
 CONFIG_MACH_SNOWBALL=y
 CONFIG_MACH_U5500=y
+CONFIG_MACH_UX500_DT=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_SMP=y
diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 5cfa539..afb3706 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -50,6 +50,12 @@ config MACH_U5500
 	depends on UX500_SOC_DB5500
 	help
 	  Include support for the U5500 development platform.
+
+config MACH_UX500_DT
+	bool "Generic U8500 support using device tree"
+	depends on MACH_U8500
+	select USE_OF
+
 endmenu
 
 config UX500_DEBUG_UART
-- 
1.7.5.4
