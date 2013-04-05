From: padma.v@samsung.com (Padmavathi Venna)
Date: Fri, 05 Apr 2013 11:53:48 +0530
Subject: [PATCH 2/3] ARM: dts: add Exynos audio subsystem clock controller node
In-Reply-To: <1365143029-16936-1-git-send-email-padma.v@samsung.com>
References: <1365143029-16936-1-git-send-email-padma.v@samsung.com>
Message-ID: <1365143029-16936-2-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Audio subsystem introduced in exynos platforms which has a
internal clock controller. This patch adds a node for the same.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/boot/dts/exynos5250.dtsi |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 7751e69..14d454c 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -67,6 +67,12 @@
 		#clock-cells = <1>;
 	};
 
+	clock_audss: audss-clock-controller at 0x03810000 {
+		compatible = "samsung,exynos-audss-clock";
+		reg = <0x03810000 0x100>;
+		#clock-cells = <1>;
+	};
+
 	gic:interrupt-controller at 10481000 {
 		compatible = "arm,cortex-a9-gic";
 		#interrupt-cells = <3>;
-- 
1.7.4.4
