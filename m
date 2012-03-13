From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 13 Mar 2012 13:33:44 +0100
Subject: [PATCH 5/5 v4] ARM: at91: sam9x5 add i2c DT support
In-Reply-To: <a>
References: <a>
Message-ID: <1331642024-19869-5-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For now on use i2c-gpio driver on the same pin as the hardware IP.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
Acked-by: Rob Herring <rob.herring@calxeda.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: devicetree-discuss at lists.ozlabs.org
---
 arch/arm/boot/dts/at91sam9x5.dtsi |   39 +++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index c294657..f0104f4 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -188,4 +188,43 @@
 			status = "disabled";
 		};
 	};
+
+	i2c at 0 {
+		compatible = "i2c-gpio";
+		gpios = <&pioA 30 0 /* sda */
+			 &pioA 31 0 /* scl */
+			>;
+		i2c-gpio,sda-open-drain;
+		i2c-gpio,scl-open-drain;
+		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	i2c at 1 {
+		compatible = "i2c-gpio";
+		gpios = <&pioC 0 0 /* sda */
+			 &pioC 1 0 /* scl */
+			>;
+		i2c-gpio,sda-open-drain;
+		i2c-gpio,scl-open-drain;
+		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	i2c at 2 {
+		compatible = "i2c-gpio";
+		gpios = <&pioB 4 0 /* sda */
+			 &pioB 5 0 /* scl */
+			>;
+		i2c-gpio,sda-open-drain;
+		i2c-gpio,scl-open-drain;
+		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
 };
-- 
1.7.7
