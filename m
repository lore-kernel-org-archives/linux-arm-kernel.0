From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue,  6 May 2014 02:14:10 +0200
Subject: [PATCH v3 15/20] ARM: mvebu: Add Device Tree description of USB
 cluster controller on Armada 375
In-Reply-To: <1399335255-589-1-git-send-email-gregory.clement@free-electrons.com>
References: <1399335255-589-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1399335255-589-16-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Armada 375, the USB cluster allows to control the cluster composed
of the USB2 and USB3 host controllers.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-375.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index 3877693fb2d8..6724c10a8862 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -320,6 +320,12 @@
 				clocks = <&coreclk 0>;
 			};
 
+			usbcluster: usb-cluster at 18400 {
+				compatible = "marvell,armada-375-usb-cluster";
+				reg = <0x18400 0x4>;
+				#phy-cells = <1>;
+			};
+
 			xor at 60800 {
 				compatible = "marvell,orion-xor";
 				reg = <0x60800 0x100
-- 
1.8.1.2
