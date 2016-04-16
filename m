From: david@lechnology.com (David Lechner)
Date: Sat, 16 Apr 2016 12:00:19 -0500
Subject: [PATCH v2 3/4] ARM: davinci: disable mdio and eth0 in da850.dtsi
In-Reply-To: <1460826020-1256-1-git-send-email-david@lechnology.com>
References: <1460826020-1256-1-git-send-email-david@lechnology.com>
Message-ID: <1460826020-1256-4-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All other devices are disabled by default and not all boards will use
these devices, so these should be disabled too..

da850-evm.dtb already had status = "okay" for these devices.
da850-enbw-cmc.dts did not, so they were added.

Signed-off-by: David Lechner <david@lechnology.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
---

no change

 arch/arm/boot/dts/da850-enbw-cmc.dts | 6 ++++++
 arch/arm/boot/dts/da850.dtsi         | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/da850-enbw-cmc.dts b/arch/arm/boot/dts/da850-enbw-cmc.dts
index 101d1a1..14dff3e 100644
--- a/arch/arm/boot/dts/da850-enbw-cmc.dts
+++ b/arch/arm/boot/dts/da850-enbw-cmc.dts
@@ -26,6 +26,12 @@
 		serial2: serial at 10d000 {
 			status = "okay";
 		};
+		mdio: mdio at 224000 {
+			status = "okay";
+		};
+		eth0: ethernet at 220000 {
+			status = "okay";
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 8880d57..26fc0812 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -330,6 +330,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x224000 0x1000>;
+			status = "disabled";
 		};
 		eth0: ethernet at 220000 {
 			compatible = "ti,davinci-dm6467-emac";
@@ -344,6 +345,7 @@
 					35
 					36
 					>;
+			status = "disabled";
 		};
 		gpio: gpio at 226000 {
 			compatible = "ti,dm6441-gpio";
-- 
1.9.1
