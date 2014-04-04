From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  4 Apr 2014 17:42:05 +0200
Subject: [PATCH 2/2] ARM: configs: add CONFIG_MMC_SDHCI_PXAV3 to the relevant
 defconfigs
In-Reply-To: <1396626125-8631-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1396626125-8631-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1396626125-8631-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell Armada 38x platform has a SDHCI interface managed by the
sdhci-pxav3 MMC host driver. It therefore makes sense to enable this
driver in both mvebu_v7_defconfig and multi_v7_defconfig, which are
both capable of building Marvell Armada 38x support.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 arch/arm/configs/mvebu_v7_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index de52231..db44b74 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -270,6 +270,7 @@ CONFIG_MMC_BLOCK_MINORS=16
 CONFIG_MMC_ARMMMCI=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ESDHC_IMX=y
+CONFIG_MMC_SDHCI_PXAV3=y
 CONFIG_MMC_SDHCI_TEGRA=y
 CONFIG_MMC_SDHCI_SPEAR=y
 CONFIG_MMC_SDHCI_BCM_KONA=y
diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
index a34713d..26be7ff 100644
--- a/arch/arm/configs/mvebu_v7_defconfig
+++ b/arch/arm/configs/mvebu_v7_defconfig
@@ -79,6 +79,7 @@ CONFIG_USB_EHCI_ROOT_HUB_TT=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_MMC=y
+CONFIG_MMC_SDHCI_PXAV3=y
 CONFIG_MMC_MVSDIO=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_GPIO=y
-- 
1.8.3.2
