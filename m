From: r65037@freescale.com (Richard Zhu)
Date: Fri, 24 Sep 2010 11:54:27 +0800
Subject: [PATCH 4/4] esdhc-4 mx51: enable fsl esdhc driver
In-Reply-To: <1285300467-5158-4-git-send-email-r65037@freescale.com>
References: <1285300467-5158-1-git-send-email-r65037@freescale.com>
	<1285300467-5158-2-git-send-email-r65037@freescale.com>
	<1285300467-5158-3-git-send-email-r65037@freescale.com>
	<1285300467-5158-4-git-send-email-r65037@freescale.com>
Message-ID: <1285300467-5158-5-git-send-email-r65037@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the fsl esdhc driver on mx51 platforms

Signed-off-by: Richard Zhu <r65037@freescale.com>
---
 arch/arm/configs/mx51_defconfig |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/mx51_defconfig b/arch/arm/configs/mx51_defconfig
index a665ecb..4f3067b 100644
--- a/arch/arm/configs/mx51_defconfig
+++ b/arch/arm/configs/mx51_defconfig
@@ -106,8 +106,13 @@ CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_MXC=y
 CONFIG_MMC=y
-CONFIG_MMC_BLOCK=m
-CONFIG_MMC_SDHCI=m
+CONFIG_MMC_BLOCK=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_IO_ACCESSORS=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_IMX=y
+# CONFIG_MMC_MXC is not set
+# CONFIG_MEMSTICK is not set
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=m
 CONFIG_RTC_CLASS=y
-- 
1.7.0
