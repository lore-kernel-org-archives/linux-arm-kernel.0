From: briannorris@chromium.org (Brian Norris)
Date: Fri,  5 Jan 2018 16:47:57 -0800
Subject: [PATCH 3/3] arm64: tegra: remove tegra132 norrin's nonstandard
 'backlight-boot-off'
In-Reply-To: <20180106004757.8239-1-briannorris@chromium.org>
References: <20180106004757.8239-1-briannorris@chromium.org>
Message-ID: <20180106004757.8239-3-briannorris@chromium.org>
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
 arch/arm64/boot/dts/nvidia/tegra132-norrin.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts b/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
index a0385a386a3f..ba2e1b7c198e 100644
--- a/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
@@ -951,8 +951,6 @@
 
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
-
-		backlight-boot-off;
 	};
 
 	clocks {
-- 
2.16.0.rc0.223.g4a4ac83678-goog
