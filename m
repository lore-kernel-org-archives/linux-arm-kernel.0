From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 17 Aug 2014 11:52:10 +0800
Subject: [PATCH 04/12] ARM: dts: sun8i: Add pin muxing option for R_UART
In-Reply-To: <1408247538-16950-1-git-send-email-wens@csie.org>
References: <1408247538-16950-1-git-send-email-wens@csie.org>
Message-ID: <1408247538-16950-5-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

R_UART is available on extra pads on certain tablets, which makes it
ideal for use as a console. Here we add the pins for it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a23.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index 0d6bb6d..25bae1f 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -372,6 +372,13 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			#gpio-cells = <3>;
+
+			r_uart_pins_a: r_uart at 0 {
+				allwinner,pins = "PL2", "PL3";
+				allwinner,function = "s_uart";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
 		};
 	};
 };
-- 
2.1.0
