From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 29 Feb 2012 15:20:18 +0100
Subject: [PATCH 2/5 v2] ARM: at91: sam9g20 add i2c DT support
In-Reply-To: <1330525221-25651-1-git-send-email-plagnioj@jcrosoft.com>
References: <1330525221-25651-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1330525221-25651-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For now on use i2c-gpio driver on the same pin as the hardware IP.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: devicetree-discuss at lists.ozlabs.org
---
 arch/arm/boot/dts/at91sam9g20.dtsi |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
index 9e5f933..cfc5e63 100644
--- a/arch/arm/boot/dts/at91sam9g20.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20.dtsi
@@ -188,6 +188,18 @@
 				status = "disabled";
 			};
 
+			i2c-gpio at 0 {
+				compatible = "i2c-gpio";
+				gpios = <&pioA 23 0 /* sda */
+					 &pioA 24 0 /* scl */
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
