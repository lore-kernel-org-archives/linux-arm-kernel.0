From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Thu, 14 May 2015 19:12:13 +0900
Subject: [PATCH v5 06/13] ARM: dts: Use labels for overriding nodes in
 exynos4212
In-Reply-To: <1431598340-3319-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1431598340-3319-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1431598340-3319-7-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Usage of labels instead of full paths reduces possible mistakes when
overriding nodes.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 arch/arm/boot/dts/exynos4212.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4212.dtsi b/arch/arm/boot/dts/exynos4212.dtsi
index 5be03288f1ee..d9c8efeef208 100644
--- a/arch/arm/boot/dts/exynos4212.dtsi
+++ b/arch/arm/boot/dts/exynos4212.dtsi
@@ -41,12 +41,12 @@
 			reg = <0xA01>;
 		};
 	};
+};
 
-	combiner: interrupt-controller at 10440000 {
-		samsung,combiner-nr = <18>;
-	};
+&combiner {
+	samsung,combiner-nr = <18>;
+};
 
-	gic: interrupt-controller at 10490000 {
-		cpu-offset = <0x8000>;
-	};
+&gic {
+	cpu-offset = <0x8000>;
 };
-- 
2.1.4
