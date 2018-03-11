From: amonakov@ispras.ru (Alexander Monakov)
Date: Sun, 11 Mar 2018 19:00:04 +0300
Subject: [PATCH 4/8] ARM: dts: berlin2cd: add ADC/thermal sensor node
In-Reply-To: <20180311160008.22928-1-amonakov@ispras.ru>
References: <20180311160008.22928-1-amonakov@ispras.ru>
Message-ID: <20180311160008.22928-5-amonakov@ispras.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
---
 arch/arm/boot/dts/berlin2cd.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2cd.dtsi b/arch/arm/boot/dts/berlin2cd.dtsi
index 572e99ce5940..c6929f84b201 100644
--- a/arch/arm/boot/dts/berlin2cd.dtsi
+++ b/arch/arm/boot/dts/berlin2cd.dtsi
@@ -480,6 +480,12 @@
 				sys_pinctrl: pin-controller {
 					compatible = "marvell,berlin2cd-system-pinctrl";
 				};
+
+				adc: adc {
+					compatible = "marvell,berlin2-adc";
+					interrupts = <12>, <14>;
+					interrupt-names = "adc", "tsen";
+				};
 			};
 
 			sic: interrupt-controller at e000 {
-- 
2.11.0
