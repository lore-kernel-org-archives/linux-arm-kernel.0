From: dianders@chromium.org (Doug Anderson)
Date: Mon,  8 Apr 2013 09:51:19 -0700
Subject: [PATCH] ARM: dts: fix bad merge of display timing node to
 exynos5250-smdk5250.dts
Message-ID: <1365439879-3398-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The display timing node was added:
  7ed2077 ARM: dts: Add display timing node to exynos5250-smdk5250.dts
...and looks OK there.  ...but it looks like we lost a "};" in the
merge and it no longer compiles.  Fix it.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 arch/arm/boot/dts/exynos5250-smdk5250.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index 4be14df..26d856b 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -239,6 +239,7 @@
 			vback-porch = <4>;
 			vfront-porch = <4>;
 			vsync-len = <4>;
+		};
 	};
 
 	fixed-rate-clocks {
-- 
1.8.1.3
