From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu,  8 Mar 2012 09:50:34 +0100
Subject: [PATCH 4/5 v3] ARM: at91: sam9g45 add i2c DT support
In-Reply-To: <1331196635-27203-1-git-send-email-plagnioj@jcrosoft.com>
References: <1331196635-27203-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1331196635-27203-4-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For now on use i2c-gpio driver on the same pin as the hardware IP.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: devicetree-discuss at lists.ozlabs.org
---
v3:

	update i2c binding (Rob comments)

Best Regards,
J.
 arch/arm/boot/dts/at91sam9g45.dtsi |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index d79021b..4a8a36d 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -197,4 +197,17 @@
 			status = "disabled";
 		};
 	};
+
+	i2c-gpio at 0 {
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
