From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun,  5 Feb 2012 11:38:56 +0100
Subject: [PATCH 4/4] ARM: at91: sam9g45 add i2c DT support
In-Reply-To: <1328438337-21185-1-git-send-email-plagnioj@jcrosoft.com>
References: <1328438337-21185-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1328438337-21185-4-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

for now on use gpio-i2c driver on the same pin as the hardware IP

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: devicetree-discuss at lists.ozlabs.org
---
 arch/arm/boot/dts/at91sam9g45.dtsi |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index a12ebc4..951b2c8 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -211,6 +211,19 @@
 				status = "disabled";
 			};
 
+			i2c-gpio at 0 {
+				compatible = "gpio-i2c";
+				gpios = <&pioA 20 0 /* sda */
+					 &pioA 21 0 /* scl */
+					>;
+				gpio-i2c,sda_is_open_drain;
+				gpio-i2c,scl_is_open_drain;
+				udelay = <5>;		/* ~100 kHz */
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 		};
 	};
 };
-- 
1.7.7
