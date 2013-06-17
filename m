From: dianders@chromium.org (Doug Anderson)
Date: Mon, 17 Jun 2013 08:06:12 -0700
Subject: [PATCH] ARM: dts: Enable RTC node for exynos5250-snow
Message-ID: <1371481572-926-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By default the exynos RTC is disabled.  Enable it for snow.  There's
also an external RTC on the max77686 PMIC but we haven't yet enabled
that.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 arch/arm/boot/dts/exynos5250-snow.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index d449feb..05244f1 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -171,6 +171,10 @@
 		};
 	};
 
+	rtc {
+		status = "okay";
+	};
+
 	/*
 	 * On Snow we've got SIP WiFi and so can keep drive strengths low to
 	 * reduce EMI.
-- 
1.8.3
