From: david@lechnology.com (David Lechner)
Date: Wed, 16 Mar 2016 21:26:41 -0500
Subject: [PATCH v2 08/11] ARM: dt: da850: Add usb phy node
In-Reply-To: <1458181615-27782-1-git-send-email-david@lechnology.com>
References: <1458181615-27782-1-git-send-email-david@lechnology.com>
Message-ID: <1458181615-27782-9-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a node for the new usb phy driver.

Signed-off-by: David Lechner <david@lechnology.com>
---

v2 changes: This is new patch in v2.


 arch/arm/boot/dts/da850.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 591660d..06f36cd 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -324,6 +324,12 @@
 					>;
 			status = "disabled";
 		};
+		usbphy: usbphy at 1c14184 {
+			compatible = "ti,da830-usbphy";
+			#phy-cells = <1>;
+			reg = <0x14184 4>;
+			status = "disabled";
+		};
 		gpio: gpio at 1e26000 {
 			compatible = "ti,dm6441-gpio";
 			gpio-controller;
-- 
1.9.1
