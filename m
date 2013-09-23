From: bcm@fixthebug.org (Christian Daudt)
Date: Mon, 23 Sep 2013 10:20:35 -0700
Subject: [PATCH v2 3/4] rename ARCH_BCM to ARCH_BCM_MOBILE (mmc)
In-Reply-To: <1379956836-5866-1-git-send-email-bcm@fixthebug.org>
References: <1379956836-5866-1-git-send-email-bcm@fixthebug.org>
Message-ID: <1379956836-5866-4-git-send-email-bcm@fixthebug.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently ARCH_BCM has been used for Broadcom
Mobile V7 based SoCs. In order to allow other Broadcom
SoCs to also use mach-bcm directory and files, this patch
renames the original ARCH_BCM to ARCH_BCM_MOBILE, and
uses ARCH_BCM to define any Broadcom chip residing
in mach-bcm directory.

Signed-off-by: Christian Daudt <bcm@fixthebug.org>
Acked-by: Olof Johansson <olof@lixom.net>

Changes from v1:
 - fix alpha ordering in dts/Makefile
 - break into 4 patches for separate subsys

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 7fc5099..7e89650 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -251,7 +251,7 @@ config MMC_SDHCI_S3C_DMA
 
 config MMC_SDHCI_BCM_KONA
 	tristate "SDHCI support on Broadcom KONA platform"
-	depends on ARCH_BCM
+	depends on ARCH_BCM_MOBILE
 	select MMC_SDHCI_PLTFM
 	help
 	  This selects the Broadcom Kona Secure Digital Host Controller
-- 
1.7.10.4
