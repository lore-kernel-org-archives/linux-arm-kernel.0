From: padma.v@samsung.com (Padmavathi Venna)
Date: Wed, 12 Jun 2013 13:37:40 +0530
Subject: [PATCH V6 3/6] ARM: dts: add Exynos audio subsystem clock controller
 node
In-Reply-To: <1371024463-303-1-git-send-email-padma.v@samsung.com>
References: <1371024463-303-1-git-send-email-padma.v@samsung.com>
Message-ID: <1371024463-303-4-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Audio subsystem introduced in s5pv210 and exynos platforms
which has a internal clock controller. This patch adds a node
for the same on exynos5250.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Reviewed-by: Doug Anderson <dianders@chromium.org>
---
 arch/arm/boot/dts/exynos5250.dtsi |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 5cfc5b7..84edf42 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -72,6 +72,12 @@
 		#clock-cells = <1>;
 	};
 
+	clock_audss: audss-clock-controller at 3810000 {
+		compatible = "samsung,exynos5250-audss-clock";
+		reg = <0x03810000 0x0C>;
+		#clock-cells = <1>;
+	};
+
 	gic:interrupt-controller at 10481000 {
 		compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
 		#interrupt-cells = <3>;
-- 
1.7.4.4
