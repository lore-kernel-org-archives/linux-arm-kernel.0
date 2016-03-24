From: david@lechnology.com (David Lechner)
Date: Thu, 24 Mar 2016 18:51:38 -0500
Subject: [PATCH v3 13/16] ARM: dt: da850: Add usb phy node
In-Reply-To: <1458863503-31121-1-git-send-email-david@lechnology.com>
References: <1458863503-31121-1-git-send-email-david@lechnology.com>
Message-ID: <1458863503-31121-14-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a node for the new usb phy driver.

Signed-off-by: David Lechner <david@lechnology.com>
---

v3 changes:

* No longer needs reg property since we are now using syscon instead.


 arch/arm/boot/dts/da850.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index a360713..83ea8f6 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -313,6 +313,11 @@
 					36
 					>;
 		};
+		usbphy: usbphy {
+			compatible = "ti,da830-usbphy";
+			#phy-cells = <1>;
+			status = "disabled";
+		};
 		gpio: gpio at 226000 {
 			compatible = "ti,dm6441-gpio";
 			gpio-controller;
-- 
1.9.1
