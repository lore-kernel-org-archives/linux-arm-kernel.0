From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 23 Nov 2012 19:45:32 +0100
Subject: [PATCH 3/3] ARM: at91: usb-a9g20: dt: add mmc-spi support
In-Reply-To: <1353696332-12741-1-git-send-email-plagnioj@jcrosoft.com>
References: <20121123184115.GB4398@game.jcrosoft.org>
 <1353696332-12741-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1353696332-12741-3-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/usb_a9g20.dts |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/usb_a9g20.dts b/arch/arm/boot/dts/usb_a9g20.dts
index 2dacb16c..503f604 100644
--- a/arch/arm/boot/dts/usb_a9g20.dts
+++ b/arch/arm/boot/dts/usb_a9g20.dts
@@ -21,6 +21,22 @@
 		reg = <0x20000000 0x4000000>;
 	};
 
+	ahb {
+		apb {
+			spi1: spi at fffcc000 {
+				cs-gpios = <&pioB 3 0>;
+				status = "okay";
+
+				mmc-slot at 0 {
+					compatible = "mmc-spi-slot";
+					reg = <0>;
+					gpios = <&pioC 4 0>;	/* CD */
+					spi-max-frequency = <25000000>;
+				};
+			};
+		};
+	};
+
 	i2c at 0 {
 		rv3029c2 at 56 {
 			compatible = "rv3029c2";
-- 
1.7.10.4
