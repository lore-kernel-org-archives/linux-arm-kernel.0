From: marvin24@gmx.de (Marc Dietrich)
Date: Sun,  7 Aug 2011 21:00:55 +0200
Subject: [PATCH 5/5] ARM: tegra: paz00: reorder the SDHCI channel init
In-Reply-To: <cover.1312735430.git.marvin24@gmx.de>
References: <cover.1312735430.git.marvin24@gmx.de>
Message-ID: <661bd93853be4f54ec0aadde114b31c524cc22f4.1312742856.git.marvin24@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reorders the SDHCI channel init order. With this patch, the
internal emmc gets the mmcblk0 device while the external sdmmc port
gets mmcblk1. This change is only for convenience.

Signed-off-by: Marc Dietrich <marvin24@gmx.de>
---
 arch/arm/mach-tegra/board-paz00.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
index 8a2d1ce..bcfcacc 100644
--- a/arch/arm/mach-tegra/board-paz00.c
+++ b/arch/arm/mach-tegra/board-paz00.c
@@ -114,8 +114,8 @@ static struct platform_device leds_gpio = {
 
 static struct platform_device *paz00_devices[] __initdata = {
 	&debug_uart,
-	&tegra_sdhci_device1,
 	&tegra_sdhci_device4,
+	&tegra_sdhci_device1,
 	&wifi_rfkill_device,
 	&leds_gpio,
 };
-- 
1.7.4.1
