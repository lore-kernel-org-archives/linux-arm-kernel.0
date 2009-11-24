From: saeed@marvell.com (Saeed Bishara)
Date: Tue, 24 Nov 2009 19:33:53 +0200
Subject: [PATCH 3/3] rtc: add support for Dove soc to the rtc-mv driver.
In-Reply-To: <1259084033-7283-3-git-send-email-saeed@marvell.com>
References: <1259084033-7283-1-git-send-email-saeed@marvell.com>
	<1259084033-7283-2-git-send-email-saeed@marvell.com>
	<1259084033-7283-3-git-send-email-saeed@marvell.com>
Message-ID: <1259084033-7283-4-git-send-email-saeed@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 arch/arm/configs/dove_defconfig |    3 ++-
 drivers/rtc/Kconfig             |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/dove_defconfig b/arch/arm/configs/dove_defconfig
index 837bb52..b3a4916 100644
--- a/arch/arm/configs/dove_defconfig
+++ b/arch/arm/configs/dove_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.32-rc6
-# Tue Nov 24 13:51:23 2009
+# Tue Nov 24 13:53:37 2009
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -1209,6 +1209,7 @@ CONFIG_RTC_INTF_DEV=y
 #
 # on-CPU RTC drivers
 #
+CONFIG_RTC_DRV_MV=y
 CONFIG_DMADEVICES=y
 
 #
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 3c20dae..e11e1cd 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -780,7 +780,7 @@ config RTC_DRV_TX4939
 
 config RTC_DRV_MV
 	tristate "Marvell SoC RTC"
-	depends on ARCH_KIRKWOOD
+	depends on ARCH_KIRKWOOD || ARCH_DOVE
 	help
 	  If you say yes here you will get support for the in-chip RTC
 	  that can be found in some of Marvell's SoC devices, such as
-- 
1.6.0.4
