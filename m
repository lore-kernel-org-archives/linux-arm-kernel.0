From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 20 Feb 2014 14:37:20 -0700
Subject: [PATCH] ARM: tegra: add LED options back into tegra_defconfig
Message-ID: <1392932240-14480-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

The last time tegra_defconfig was rebuilt, various LEDs options were
somehow selected by other options, and hence their entries in
tegra_defconfig were removed by "make savedefconfig". However, for some
reason this is no longer happening, so we need to add the entries back
into tegra_defconfig so the they are enabled in .config.

Fixes: db079b1811d1 ("ARM: tegra: rebuild tegra_defconfig to add DEBUG_FS)"
Reported-by: Marc Dietrich <marvin24@gmx.de>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Another fix for 3.14.

 arch/arm/configs/tegra_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 00fe9e9710fd..27d69b558c5d 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -204,7 +204,10 @@ CONFIG_MMC_BLOCK_MINORS=16
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_TEGRA=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=y
 CONFIG_LEDS_TRIGGER_ONESHOT=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
-- 
1.8.1.5
