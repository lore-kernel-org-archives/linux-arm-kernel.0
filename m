From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Sun, 20 Apr 2014 16:53:59 +0530
Subject: [PATCH 2/7] ARM: dtsi: add node for simple phy provider for exynos5420
In-Reply-To: <1397993044-14564-1-git-send-email-rahul.sharma@samsung.com>
References: <1397993044-14564-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1397993044-14564-3-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rahul Sharma <Rahul.Sharma@samsung.com>

Add dt node for simple phy provider for exynos5420 SoC.

Signed-off-by: Rahul Sharma <Rahul.Sharma@samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)
 mode change 100644 => 100755 arch/arm/boot/dts/exynos5420.dtsi

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
old mode 100644
new mode 100755
index c3a9a66..07a6cdc
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -732,4 +732,10 @@
 		clock-names = "secss";
 		samsung,power-domain = <&g2d_pd>;
 	};
+
+	simple_phys: simple-phys at 10040000 {
+		compatible = "samsung,exynos5420-simple-phy";
+		reg = <0x10040000 0x10000>;
+		#phy-cells = <1>;
+	};
 };
-- 
1.7.9.5
