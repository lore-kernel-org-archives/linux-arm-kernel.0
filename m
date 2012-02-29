From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 29 Feb 2012 15:20:21 +0100
Subject: [PATCH 5/5 v2] ARM: at91: sam9x5 add i2c DT support
In-Reply-To: <1330525221-25651-1-git-send-email-plagnioj@jcrosoft.com>
References: <1330525221-25651-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1330525221-25651-5-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For now on use i2c-gpio driver on the same pin as the hardware IP.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: devicetree-discuss at lists.ozlabs.org
---
 arch/arm/boot/dts/at91sam9x5.dtsi |   39 +++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index cbf331f..d71bc30 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -186,6 +186,45 @@
 					>;
 				status = "disabled";
 			};
+
+			i2c-gpio at 0 {
+				compatible = "i2c-gpio";
+				gpios = <&pioA 30 0 /* sda */
+					 &pioA 31 0 /* scl */
+					>;
+				i2c-gpio,sda-open-drain;
+				i2c-gpio,scl-open-drain;
+				udelay = <2>;		/* ~100 kHz */
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c-gpio at 1 {
+				compatible = "i2c-gpio";
+				gpios = <&pioC 0 0 /* sda */
+					 &pioC 1 0 /* scl */
+					>;
+				i2c-gpio,sda-open-drain;
+				i2c-gpio,scl-open-drain;
+				udelay = <2>;		/* ~100 kHz */
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c-gpio at 2 {
+				compatible = "i2c-gpio";
+				gpios = <&pioB 4 0 /* sda */
+					 &pioB 5 0 /* scl */
+					>;
+				i2c-gpio,sda-open-drain;
+				i2c-gpio,scl-open-drain;
+				udelay = <2>;		/* ~100 kHz */
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
 		};
 	};
 };
-- 
1.7.7
