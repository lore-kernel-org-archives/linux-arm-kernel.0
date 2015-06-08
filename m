From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 08 Jun 2015 10:11:39 +0900
Subject: [PATCH 2/2] ARM: dts: Set max17047 over heat and over voltage
 thresholds
In-Reply-To: <1433725899-13849-1-git-send-email-k.kozlowski@samsung.com>
References: <1433725899-13849-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1433725899-13849-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add some safe values for over head and over voltage. The Trats2 uses 3.8
V battery and during testing it operated properly under 4.48 V.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos4412-trats2.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 0b228ee14c64..8a87d39a28a0 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -595,6 +595,9 @@
 			interrupt-parent = <&gpx2>;
 			interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
 			reg = <0x36>;
+
+			maxim,over-heat-temp = <700>;
+			maxim,over-volt = <4500>;
 		};
 	};
 
-- 
1.9.1
