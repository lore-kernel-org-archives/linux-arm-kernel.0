From: stefan@agner.ch (Stefan Agner)
Date: Fri,  1 Apr 2016 23:08:19 -0700
Subject: [PATCH] ARM: dts: armv7-m: add address to unit name
Message-ID: <1459577299-2818-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add address to unit name to remove the following warning:
 Warning (unit_address_vs_reg): Node /nv-interrupt-controller has a
 reg or ranges property, but no unit name

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Hi Arnd,

Not sure through which tree this should go but an earlier patch
seemd to be applied directly by you...

--
Stefan

 arch/arm/boot/dts/armv7-m.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armv7-m.dtsi b/arch/arm/boot/dts/armv7-m.dtsi
index b1ad7cf..8126bec 100644
--- a/arch/arm/boot/dts/armv7-m.dtsi
+++ b/arch/arm/boot/dts/armv7-m.dtsi
@@ -1,7 +1,7 @@
 #include "skeleton.dtsi"
 
 / {
-	nvic: nv-interrupt-controller  {
+	nvic: nv-interrupt-controller at 0xe000e100 {
 		compatible = "arm,armv7m-nvic";
 		interrupt-controller;
 		#interrupt-cells = <1>;
-- 
2.7.4
