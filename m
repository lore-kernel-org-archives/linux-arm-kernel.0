From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 24 Oct 2014 17:24:13 +0200
Subject: [PATCH v2 5/6] ARM: mvebu: add Device Tree description of USB cluster
 controller on Armada 375
In-Reply-To: <1414164254-13053-1-git-send-email-gregory.clement@free-electrons.com>
References: <1414164254-13053-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1414164254-13053-6-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Armada 375, the USB cluster allows to control the cluster composed
of the USB2 and USB3 host controllers.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-375.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index de6571445cef..8f45cf5d2a50 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -342,6 +342,12 @@
 				#clock-cells = <1>;
 			};
 
+			usbcluster: usb-cluster at 18400 {
+				compatible = "marvell,armada-375-usb-cluster";
+				reg = <0x18400 0x4>;
+				#phy-cells = <1>;
+			};
+
 			mbusc: mbus-controller at 20000 {
 				compatible = "marvell,mbus-controller";
 				reg = <0x20000 0x100>, <0x20180 0x20>;
-- 
1.9.1
