From: chanho61.park@samsung.com (Chanho Park)
Date: Mon, 22 Jul 2013 15:49:27 +0900
Subject: [PATCH 3/3] dts: ARM: add a rotator node for exynos4
In-Reply-To: <1374475767-30085-1-git-send-email-chanho61.park@samsung.com>
References: <1374475767-30085-1-git-send-email-chanho61.park@samsung.com>
Message-ID: <1374475767-30085-4-git-send-email-chanho61.park@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a device node of rotator for exynos4 platform. It has proper
register and clock information. It also has limit table to get restrictions of
the image size.

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 3f94fe8..7d7dcef 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -398,4 +398,27 @@
 		samsung,power-domain = <&pd_lcd0>;
 		status = "disabled";
 	};
+
+	rotator: rotator at 12810000 {
+		compatible = "samsung,exynos4210-rotator";
+		reg = <0x12810000 0x1000>;
+		interrupts = <0 83 0>;
+		clocks = <&clock 278>;
+		clock-names = "rotator";
+		status = "disabled";
+		ycbcr420_2p {
+			min_w = <32>;
+			min_h = <32>;
+			max_w = <32768>;
+			max_h = <32768>;
+			align = <3>;
+		};
+		rgb888 {
+			min_w = <8>;
+			min_h = <8>;
+			max_w = <8192>;
+			max_h = <8192>;
+			align = <2>;
+		};
+	};
 };
-- 
1.7.9.5
