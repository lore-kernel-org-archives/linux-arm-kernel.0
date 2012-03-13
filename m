From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 13 Mar 2012 13:33:43 +0100
Subject: [PATCH 4/5 v4] ARM: at91: sam9g45 add i2c DT support
In-Reply-To: <a>
References: <a>
Message-ID: <1331642024-19869-4-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For now on use i2c-gpio driver on the same pin as the hardware IP.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
Acked-by: Rob Herring <rob.herring@calxeda.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: devicetree-discuss at lists.ozlabs.org
---
 arch/arm/boot/dts/at91sam9g45.dtsi |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index d79021b..92fe5a5 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -197,4 +197,17 @@
 			status = "disabled";
 		};
 	};
+
+	i2c at 0 {
+		compatible = "i2c-gpio";
+		gpios = <&pioA 20 0 /* sda */
+			 &pioA 21 0 /* scl */
+			>;
+		i2c-gpio,sda-open-drain;
+		i2c-gpio,scl-open-drain;
+		i2c-gpio,delay-us = <5>;	/* ~100 kHz */
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
 };
-- 
1.7.7
