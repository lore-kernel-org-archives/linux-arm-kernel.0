From: stefan@agner.ch (Stefan Agner)
Date: Fri,  1 Apr 2016 23:13:39 -0700
Subject: [PATCH 1/3] ARM: dts: vf-colibri: alias the primary FEC as ethernet0
Message-ID: <1459577621-3160-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Vybrid based Colibri modules provide a on-module PHY which is
connected to the second FEC instance FEC1. Since the on-module
Ethernet port is considered as primary ethernet interface, alias
fec1 as ethernet0. This also makes sure that the first MAC address
provided by the boot loader gets assigned to the FEC instance used
for the on-module PHY.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vf-colibri.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/vf-colibri.dtsi b/arch/arm/boot/dts/vf-colibri.dtsi
index fda7f28..7529dd7 100644
--- a/arch/arm/boot/dts/vf-colibri.dtsi
+++ b/arch/arm/boot/dts/vf-colibri.dtsi
@@ -40,6 +40,11 @@
  */
 
 / {
+	aliases {
+		ethernet0 = &fec1;
+		ethernet1 = &fec0;
+	};
+
 	bl: backlight {
 		compatible = "pwm-backlight";
 		pinctrl-names = "default";
-- 
2.7.4
