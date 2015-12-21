From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 21 Dec 2015 15:41:56 +0100
Subject: [PATCH 2/2] ARM: mvebu: use regulator-boot-on on Armada 388 GP
In-Reply-To: <1450708916-15966-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1450708916-15966-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1450708916-15966-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Really, what we meant by regulator-always-on is that the regulators
are already turned on by the bootloader, for which regulator-boot-on
is a better description.

A net advantage of using regulator-boot-on is that the regulator is
not touched at boot time by the kernel, which avoids having the hard
drives spinning down and then up again, taking several (~5) seconds of
additional boot time.

In addition, there is no need to have such properties on the child
regulators used for SATA. Having it on the parent regulator that
really controls the GPIO is sufficient.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-388-gp.dts | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/armada-388-gp.dts b/arch/arm/boot/dts/armada-388-gp.dts
index d8dab0f..1ef6cc6 100644
--- a/arch/arm/boot/dts/armada-388-gp.dts
+++ b/arch/arm/boot/dts/armada-388-gp.dts
@@ -279,7 +279,7 @@
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		enable-active-high;
-		regulator-always-on;
+		regulator-boot-on;
 		gpio = <&expander1 15 GPIO_ACTIVE_HIGH>;
 	};
 
@@ -289,7 +289,7 @@
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		enable-active-high;
-		regulator-always-on;
+		regulator-boot-on;
 		gpio = <&expander1 14 GPIO_ACTIVE_HIGH>;
 	};
 
@@ -299,7 +299,7 @@
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		enable-active-high;
-		regulator-always-on;
+		regulator-boot-on;
 		gpio = <&expander0 4 GPIO_ACTIVE_HIGH>;
 	};
 
@@ -309,7 +309,7 @@
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		enable-active-high;
-		regulator-always-on;
+		regulator-boot-on;
 		gpio = <&expander0 4 GPIO_ACTIVE_HIGH>;
 	};
 
@@ -319,7 +319,7 @@
 		regulator-min-microvolt = <12000000>;
 		regulator-max-microvolt = <12000000>;
 		enable-active-high;
-		regulator-always-on;
+		regulator-boot-on;
 		gpio = <&expander0 2 GPIO_ACTIVE_HIGH>;
 	};
 
@@ -328,7 +328,6 @@
 		regulator-name = "v5.0-sata0";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
 		vin-supply = <&reg_sata0>;
 	};
 
@@ -337,7 +336,6 @@
 		regulator-name = "v12.0-sata0";
 		regulator-min-microvolt = <12000000>;
 		regulator-max-microvolt = <12000000>;
-		regulator-always-on;
 		vin-supply = <&reg_sata0>;
 	};
 
@@ -347,7 +345,7 @@
 		regulator-min-microvolt = <12000000>;
 		regulator-max-microvolt = <12000000>;
 		enable-active-high;
-		regulator-always-on;
+		regulator-boot-on;
 		gpio = <&expander0 3 GPIO_ACTIVE_HIGH>;
 	};
 
@@ -356,7 +354,6 @@
 		regulator-name = "v5.0-sata1";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
 		vin-supply = <&reg_sata1>;
 	};
 
@@ -365,7 +362,6 @@
 		regulator-name = "v12.0-sata1";
 		regulator-min-microvolt = <12000000>;
 		regulator-max-microvolt = <12000000>;
-		regulator-always-on;
 		vin-supply = <&reg_sata1>;
 	};
 
@@ -373,7 +369,7 @@
 		compatible = "regulator-fixed";
 		regulator-name = "pwr_en_sata2";
 		enable-active-high;
-		regulator-always-on;
+		regulator-boot-on;
 		gpio = <&expander0 11 GPIO_ACTIVE_HIGH>;
 	};
 
@@ -382,7 +378,6 @@
 		regulator-name = "v5.0-sata2";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
 		vin-supply = <&reg_sata2>;
 	};
 
@@ -391,7 +386,6 @@
 		regulator-name = "v12.0-sata2";
 		regulator-min-microvolt = <12000000>;
 		regulator-max-microvolt = <12000000>;
-		regulator-always-on;
 		vin-supply = <&reg_sata2>;
 	};
 
@@ -399,7 +393,7 @@
 		compatible = "regulator-fixed";
 		regulator-name = "pwr_en_sata3";
 		enable-active-high;
-		regulator-always-on;
+		regulator-boot-on;
 		gpio = <&expander0 12 GPIO_ACTIVE_HIGH>;
 	};
 
@@ -408,7 +402,6 @@
 		regulator-name = "v5.0-sata3";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
 		vin-supply = <&reg_sata3>;
 	};
 
@@ -417,7 +410,6 @@
 		regulator-name = "v12.0-sata3";
 		regulator-min-microvolt = <12000000>;
 		regulator-max-microvolt = <12000000>;
-		regulator-always-on;
 		vin-supply = <&reg_sata3>;
 	};
 };
-- 
2.6.4
