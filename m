From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 11 May 2015 12:18:51 +0200
Subject: [PATCH v4 3/3] ARM: berlin: add an ADC node for the BG2Q
In-Reply-To: <1431339531-11938-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1431339531-11938-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1431339531-11938-4-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the ADC node for the Berlin BG2Q, using the newly added
Berlin IIO ADC driver.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index 187d056f7ad2..97c7e19e3ec6 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -565,6 +565,13 @@
 						function = "twsi3";
 					};
 				};
+
+				adc: adc {
+					compatible = "marvell,berlin2-adc";
+					interrupt-parent = <&sic>;
+					interrupts = <12>, <14>;
+					interrupt-names = "adc", "tsen";
+				};
 			};
 
 			sic: interrupt-controller at e000 {
-- 
2.4.0
