From: ralph.sennhauser@gmail.com (Ralph Sennhauser)
Date: Sun, 21 May 2017 14:48:52 +0200
Subject: [PATCH 03/13] ARM: dts: armada-385-linksys: flatten dependants
In-Reply-To: <20170521124903.11050-1-ralph.sennhauser@gmail.com>
References: <20170521124903.11050-1-ralph.sennhauser@gmail.com>
Message-ID: <20170521124903.11050-4-ralph.sennhauser@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Flatten dts of individual boards to match the new style used in
armada-385-linksys.dtsi and for the Rango addition.

* Caiman - Linksys WRT1200AC v1 & v2
* Cobra - Linksys WRT1900AC v2
* Shelby - Linksys WRT1900ACS v1 & v2

Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>

---

Notes:

  power and sata in &gpio_leds don't use references when they could,
  feels like overdoing things even though it violates one of the guiding
  principles of not recreating structure. If someone thinks such a
  change is meaningful I don't mind submitting a followup patch, though
  would look odd with the Rango dts.
---
 arch/arm/boot/dts/armada-385-linksys-caiman.dts | 99 ++++++++++++-------------
 arch/arm/boot/dts/armada-385-linksys-cobra.dts  | 99 ++++++++++++-------------
 arch/arm/boot/dts/armada-385-linksys-shelby.dts | 99 ++++++++++++-------------
 3 files changed, 138 insertions(+), 159 deletions(-)

diff --git a/arch/arm/boot/dts/armada-385-linksys-caiman.dts b/arch/arm/boot/dts/armada-385-linksys-caiman.dts
index f3cee91..765c939 100644
--- a/arch/arm/boot/dts/armada-385-linksys-caiman.dts
+++ b/arch/arm/boot/dts/armada-385-linksys-caiman.dts
@@ -44,71 +44,64 @@
 	model = "Linksys WRT1200AC";
 	compatible = "linksys,caiman", "linksys,armada385", "marvell,armada385",
 		     "marvell,armada380";
+};
 
-	soc {
-		internal-regs{
-			i2c at 11000 {
-
-				pca9635 at 68 {
-				#address-cells = <1>;
-				#size-cells = <0>;
+&expander0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 
-					wan_amber at 0 {
-						label = "caiman:amber:wan";
-						reg = <0x0>;
-					};
+	wan_amber at 0 {
+		label = "caiman:amber:wan";
+		reg = <0x0>;
+	};
 
-					wan_white at 1 {
-						label = "caiman:white:wan";
-						reg = <0x1>;
-					};
+	wan_white at 1 {
+		label = "caiman:white:wan";
+		reg = <0x1>;
+	};
 
-					wlan_2g at 2 {
-						label = "caiman:white:wlan_2g";
-						reg = <0x2>;
-					};
+	wlan_2g at 2 {
+		label = "caiman:white:wlan_2g";
+		reg = <0x2>;
+	};
 
-					wlan_5g at 3 {
-						label = "caiman:white:wlan_5g";
-						reg = <0x3>;
-					};
+	wlan_5g at 3 {
+		label = "caiman:white:wlan_5g";
+		reg = <0x3>;
+	};
 
-					usb2 at 5 {
-						label = "caiman:white:usb2";
-						reg = <0x5>;
-					};
+	usb2 at 5 {
+		label = "caiman:white:usb2";
+		reg = <0x5>;
+	};
 
-					usb3_1 at 6 {
-						label = "caiman:white:usb3_1";
-						reg = <0x6>;
-					};
+	usb3_1 at 6 {
+		label = "caiman:white:usb3_1";
+		reg = <0x6>;
+	};
 
-					usb3_2 at 7 {
-						label = "caiman:white:usb3_2";
-						reg = <0x7>;
-					};
+	usb3_2 at 7 {
+		label = "caiman:white:usb3_2";
+		reg = <0x7>;
+	};
 
-					wps_white at 8 {
-						label = "caiman:white:wps";
-						reg = <0x8>;
-					};
+	wps_white at 8 {
+		label = "caiman:white:wps";
+		reg = <0x8>;
+	};
 
-					wps_amber at 9 {
-						label = "caiman:amber:wps";
-						reg = <0x9>;
-					};
-				};
-			};
-		};
+	wps_amber at 9 {
+		label = "caiman:amber:wps";
+		reg = <0x9>;
 	};
+};
 
-	gpio-leds {
-		power {
-			label = "caiman:white:power";
-		};
+&gpio_leds {
+	power {
+		label = "caiman:white:power";
+	};
 
-		sata {
-			label = "caiman:white:sata";
-		};
+	sata {
+		label = "caiman:white:sata";
 	};
 };
diff --git a/arch/arm/boot/dts/armada-385-linksys-cobra.dts b/arch/arm/boot/dts/armada-385-linksys-cobra.dts
index 1110718..2ae1e71 100644
--- a/arch/arm/boot/dts/armada-385-linksys-cobra.dts
+++ b/arch/arm/boot/dts/armada-385-linksys-cobra.dts
@@ -44,71 +44,64 @@
 	model = "Linksys WRT1900ACv2";
 	compatible = "linksys,cobra", "linksys,armada385", "marvell,armada385",
 		     "marvell,armada380";
+};
 
-	soc {
-		internal-regs{
-			i2c at 11000 {
-
-				pca9635 at 68 {
-				#address-cells = <1>;
-				#size-cells = <0>;
+&expander0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 
-					wan_amber at 0 {
-						label = "cobra:amber:wan";
-						reg = <0x0>;
-					};
+	wan_amber at 0 {
+		label = "cobra:amber:wan";
+		reg = <0x0>;
+	};
 
-					wan_white at 1 {
-						label = "cobra:white:wan";
-						reg = <0x1>;
-					};
+	wan_white at 1 {
+		label = "cobra:white:wan";
+		reg = <0x1>;
+	};
 
-					wlan_2g at 2 {
-						label = "cobra:white:wlan_2g";
-						reg = <0x2>;
-					};
+	wlan_2g at 2 {
+		label = "cobra:white:wlan_2g";
+		reg = <0x2>;
+	};
 
-					wlan_5g at 3 {
-						label = "cobra:white:wlan_5g";
-						reg = <0x3>;
-					};
+	wlan_5g at 3 {
+		label = "cobra:white:wlan_5g";
+		reg = <0x3>;
+	};
 
-					usb2 at 5 {
-						label = "cobra:white:usb2";
-						reg = <0x5>;
-					};
+	usb2 at 5 {
+		label = "cobra:white:usb2";
+		reg = <0x5>;
+	};
 
-					usb3_1 at 6 {
-						label = "cobra:white:usb3_1";
-						reg = <0x6>;
-					};
+	usb3_1 at 6 {
+		label = "cobra:white:usb3_1";
+		reg = <0x6>;
+	};
 
-					usb3_2 at 7 {
-						label = "cobra:white:usb3_2";
-						reg = <0x7>;
-					};
+	usb3_2 at 7 {
+		label = "cobra:white:usb3_2";
+		reg = <0x7>;
+	};
 
-					wps_white at 8 {
-						label = "cobra:white:wps";
-						reg = <0x8>;
-					};
+	wps_white at 8 {
+		label = "cobra:white:wps";
+		reg = <0x8>;
+	};
 
-					wps_amber at 9 {
-						label = "cobra:amber:wps";
-						reg = <0x9>;
-					};
-				};
-			};
-		};
+	wps_amber at 9 {
+		label = "cobra:amber:wps";
+		reg = <0x9>;
 	};
+};
 
-	gpio-leds {
-		power {
-			label = "cobra:white:power";
-		};
+&gpio_leds {
+	power {
+		label = "cobra:white:power";
+	};
 
-		sata {
-			label = "cobra:white:sata";
-		};
+	sata {
+		label = "cobra:white:sata";
 	};
 };
diff --git a/arch/arm/boot/dts/armada-385-linksys-shelby.dts b/arch/arm/boot/dts/armada-385-linksys-shelby.dts
index c7a8ddd..74f4273 100644
--- a/arch/arm/boot/dts/armada-385-linksys-shelby.dts
+++ b/arch/arm/boot/dts/armada-385-linksys-shelby.dts
@@ -44,71 +44,64 @@
 	model = "Linksys WRT1900ACS";
 	compatible = "linksys,shelby", "linksys,armada385", "marvell,armada385",
 		     "marvell,armada380";
+};
 
-	soc {
-		internal-regs{
-			i2c at 11000 {
-
-				pca9635 at 68 {
-				#address-cells = <1>;
-				#size-cells = <0>;
+&expander0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 
-					wan_amber at 0 {
-						label = "shelby:amber:wan";
-						reg = <0x0>;
-					};
+	wan_amber at 0 {
+		label = "shelby:amber:wan";
+		reg = <0x0>;
+	};
 
-					wan_white at 1 {
-						label = "shelby:white:wan";
-						reg = <0x1>;
-					};
+	wan_white at 1 {
+		label = "shelby:white:wan";
+		reg = <0x1>;
+	};
 
-					wlan_2g at 2 {
-						label = "shelby:white:wlan_2g";
-						reg = <0x2>;
-					};
+	wlan_2g at 2 {
+		label = "shelby:white:wlan_2g";
+		reg = <0x2>;
+	};
 
-					wlan_5g at 3 {
-						label = "shelby:white:wlan_5g";
-						reg = <0x3>;
-					};
+	wlan_5g at 3 {
+		label = "shelby:white:wlan_5g";
+		reg = <0x3>;
+	};
 
-					usb2 at 5 {
-						label = "shelby:white:usb2";
-						reg = <0x5>;
-					};
+	usb2 at 5 {
+		label = "shelby:white:usb2";
+		reg = <0x5>;
+	};
 
-					usb3_1 at 6 {
-						label = "shelby:white:usb3_1";
-						reg = <0x6>;
-					};
+	usb3_1 at 6 {
+		label = "shelby:white:usb3_1";
+		reg = <0x6>;
+	};
 
-					usb3_2 at 7 {
-						label = "shelby:white:usb3_2";
-						reg = <0x7>;
-					};
+	usb3_2 at 7 {
+		label = "shelby:white:usb3_2";
+		reg = <0x7>;
+	};
 
-					wps_white at 8 {
-						label = "shelby:white:wps";
-						reg = <0x8>;
-					};
+	wps_white at 8 {
+		label = "shelby:white:wps";
+		reg = <0x8>;
+	};
 
-					wps_amber at 9 {
-						label = "shelby:amber:wps";
-						reg = <0x9>;
-					};
-				};
-			};
-		};
+	wps_amber at 9 {
+		label = "shelby:amber:wps";
+		reg = <0x9>;
 	};
+};
 
-	gpio-leds {
-		power {
-			label = "shelby:white:power";
-		};
+&gpio_leds {
+	power {
+		label = "shelby:white:power";
+	};
 
-		sata {
-			label = "shelby:white:sata";
-		};
+	sata {
+		label = "shelby:white:sata";
 	};
 };
-- 
2.10.2
