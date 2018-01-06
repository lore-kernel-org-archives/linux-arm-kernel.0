From: briannorris@chromium.org (Brian Norris)
Date: Fri,  5 Jan 2018 16:47:56 -0800
Subject: [PATCH 2/3] ARM: tegra: paz00: drop nonstandard 'backlight-boot-off'
In-Reply-To: <20180106004757.8239-1-briannorris@chromium.org>
References: <20180106004757.8239-1-briannorris@chromium.org>
Message-ID: <20180106004757.8239-2-briannorris@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was used out-of-tree as a hack for resolving issues where some
systems expect the backlight to turn on automatically at boot, while
others expect to manage the backlight status via a DRM/panel driver.
Those issues have since been fixed upstream in pwm_bl.c without device
tree hacks, and so this un-documented property should no longer be
useful.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 arch/arm/boot/dts/tegra20-paz00.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts
index 30436969adc0..12c63b23ed5e 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -504,8 +504,6 @@
 
 		brightness-levels = <0 16 32 48 64 80 96 112 128 144 160 176 192 208 224 240 255>;
 		default-brightness-level = <10>;
-
-		backlight-boot-off;
 	};
 
 	clocks {
-- 
2.16.0.rc0.223.g4a4ac83678-goog
