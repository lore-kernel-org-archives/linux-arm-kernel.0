From: seanpaul@chromium.org (Sean Paul)
Date: Thu, 10 Oct 2013 18:26:15 -0400
Subject: [PATCH v3 2/5] ARM: dts: Add dp-controller node to exynos5250-snow
In-Reply-To: <1381443978-5654-1-git-send-email-seanpaul@chromium.org>
References: <1380839303-4834-1-git-send-email-seanpaul@chromium.org>
 <1381443978-5654-1-git-send-email-seanpaul@chromium.org>
Message-ID: <1381443978-5654-3-git-send-email-seanpaul@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the dp-controller node to the exynos5250-snow board dts
file.

Signed-off-by: Sean Paul <seanpaul@chromium.org>
---

v2: Added dp-controller address to node (rebased on linux-next)
v3: Added status = "okay"

 arch/arm/boot/dts/exynos5250-snow.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index 28eea9b..f813644 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -186,6 +186,19 @@
 		samsung,vbus-gpio = <&gpx1 1 0>;
 	};
 
+	dp-controller at 145B0000 {
+		samsung,color-space = <0>;
+		samsung,dynamic-range = <0>;
+		samsung,ycbcr-coeff = <0>;
+		samsung,color-depth = <1>;
+		samsung,link-rate = <0x0a>;
+		samsung,lane-count = <2>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&dp_hpd>;
+		status = "okay";
+	};
+
 	fimd: fimd at 14400000 {
 		status = "okay";
 		display-timings {
-- 
1.8.4
