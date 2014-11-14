From: mw@semihalf.com (Marcin Wojtas)
Date: Fri, 14 Nov 2014 16:29:27 +0100
Subject: [PATCH v2] ARM: mvebu: re-enable SDHCI driver for Armada 38x SoC in
 v7 defconfig
Message-ID: <1415978967-7350-1-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the recent update of mvebu_v7_defconfig a config that enables sdhci-pxav3
driver, that supports SDHCI interface of Armada 38x SoC, disappeared.

This commit enables CONFIG_MMC_SDHCI_PXAV3 back.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Fixes fc9fa8714a75 ("ARM: mvebu: update v7 defconfig with useful options")
---
 arch/arm/configs/mvebu_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
index ed0a0d1..9d55170 100644
--- a/arch/arm/configs/mvebu_v7_defconfig
+++ b/arch/arm/configs/mvebu_v7_defconfig
@@ -96,6 +96,7 @@ CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_DOVE=y
+CONFIG_MMC_SDHCI_PXAV3=y
 CONFIG_MMC_MVSDIO=y
 CONFIG_LEDS_GPIO=y
 CONFIG_LEDS_CLASS=y
-- 
1.8.3.1
