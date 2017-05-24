From: j-keerthy@ti.com (Keerthy)
Date: Wed, 24 May 2017 19:31:41 +0530
Subject: [PATCH v2] ARM: dts: da850: Add interrupt-controller property to gpio
 node
Message-ID: <1495634501-3246-1-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gpio node has 144 gpios. Each gpio is capable of generating
an interrupt. Hence add interrupt-controller property to the gpio
node. With this in place one can use interrupts property in device
tree to request for the gpio interrupts.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Changes in v2:

  * Added LAKML list.
  * Chaned arm to upper case in $Subject

 arch/arm/boot/dts/da850.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 941d455..2693bd2 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -503,6 +503,8 @@
 			ti,ngpio = <144>;
 			ti,davinci-gpio-unbanked = <0>;
 			status = "disabled";
+			interrupt-controller;
+			#interrupt-cells = <2>;
 		};
 		pinconf: pin-controller at 22c00c {
 			compatible = "ti,da850-pupd";
-- 
1.9.1
