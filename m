From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed,  7 May 2014 15:52:24 +0200
Subject: [PATCHv4 18/20] ARM: mvebu: add Device Tree description of USB
 cluster controller on Armada 375
In-Reply-To: <1399470746-2948-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1399470746-2948-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1399470746-2948-19-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

On Armada 375, the USB cluster allows to control the cluster composed
of the USB2 and USB3 host controllers.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-375.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index 3877693..6724c10 100644
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
1.9.2
