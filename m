From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri,  3 Apr 2015 15:06:48 +0200
Subject: [PATCH v2 3/4] ARM: berlin: add an ADC node for the BG2Q
In-Reply-To: <1428066409-30392-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1428066409-30392-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1428066409-30392-4-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the ADC node for the Berlin BG2Q, using the newly added
Berlin IIO ADC driver.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index 187d056f7ad2..72b1c969a99d 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -565,6 +565,14 @@
 						function = "twsi3";
 					};
 				};
+
+				adc: adc {
+					compatible = "marvell,berlin2-adc";
+					interrupt-parent = <&sic>;
+					interrupts = <12>, <14>;
+					interrupt-names = "adc", "tsen";
+					status = "disabled";
+				};
 			};
 
 			sic: interrupt-controller at e000 {
-- 
2.3.4
