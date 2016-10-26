From: david@lechnology.com (David Lechner)
Date: Tue, 25 Oct 2016 22:06:51 -0500
Subject: [PATCH v6 5/5] ARM: DTS: da850: Add usb phy node
In-Reply-To: <1477451211-31979-1-git-send-email-david@lechnology.com>
References: <1477451211-31979-1-git-send-email-david@lechnology.com>
Message-ID: <1477451211-31979-6-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a node for the new usb phy driver.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/boot/dts/da850.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 6bbf20d..33fcdce 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -376,6 +376,11 @@
 					>;
 			status = "disabled";
 		};
+		usb_phy: usb-phy {
+			compatible = "ti,da830-usb-phy";
+			#phy-cells = <1>;
+			status = "disabled";
+		};
 		gpio: gpio at 226000 {
 			compatible = "ti,dm6441-gpio";
 			gpio-controller;
-- 
2.7.4
