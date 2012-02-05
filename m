From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun,  5 Feb 2012 11:38:54 +0100
Subject: [PATCH 2/4] ARM: at91s: sam9g20 add i2c DT support
In-Reply-To: <1328438337-21185-1-git-send-email-plagnioj@jcrosoft.com>
References: <1328438337-21185-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1328438337-21185-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

for now on use gpio-i2c driver on the same pin as the hardware IP

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: devicetree-discuss at lists.ozlabs.org
---
 arch/arm/boot/dts/at91sam9g20.dtsi |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
index f8f4627..d52e827 100644
--- a/arch/arm/boot/dts/at91sam9g20.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20.dtsi
@@ -220,6 +220,19 @@
 				status = "disabled";
 			};
 
+			i2c-gpio at 0 {
+				compatible = "gpio-i2c";
+				gpios = <&pioA 23 0 /* sda */
+					 &pioA 24 0 /* scl */
+					>;
+				gpio-i2c,sda_is_open_drain;
+				gpio-i2c,scl_is_open_drain;
+				udelay = <2>;		/* ~100 kHz */
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
