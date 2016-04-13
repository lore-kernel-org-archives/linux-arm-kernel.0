From: david@lechnology.com (David Lechner)
Date: Wed, 13 Apr 2016 17:30:27 -0500
Subject: [PATCH 2/3] ARM: DTS: da850: disable mdio and eth0 by default
In-Reply-To: <1460586628-25152-1-git-send-email-david@lechnology.com>
References: <1460586628-25152-1-git-send-email-david@lechnology.com>
Message-ID: <1460586628-25152-3-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All other devices are disabled by default and not all boards will use
these devices, so these should be disabled too.

da850-evm.dtb already had status = "okay" for these devices.
da850-enbw-cmc.dts did not, so they were added.

Signed-off-by: David Lechner <david@lechnology.com>
---
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
index 92b5f3c..7f3fb98 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -322,6 +322,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x224000 0x1000>;
+			status = "disabled";
 		};
 		eth0: ethernet at 220000 {
 			compatible = "ti,davinci-dm6467-emac";
@@ -336,6 +337,7 @@
 					35
 					36
 					>;
+			status = "disabled";
 		};
 		usbphy: usbphy {
 			compatible = "ti,da830-usbphy";
-- 
1.9.1
