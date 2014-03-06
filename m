From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Thu, 6 Mar 2014 18:01:34 +0530
Subject: [RESEND PATCH 1/1] arm: dts: am33xx: correcting dt node unit address
 for usb
Message-ID: <1394109094-19205-1-git-send-email-mugunthanvnm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT node's unit address should be its own register offset address to make it a
unique across the system. This patch corrects the incorrect USB entries with
correct register offset for unit address.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Felipe Balbi <balbi@ti.com>
Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
---
This patch was posted long back (Aug. 30, 2013), below is the archive of the
orginal patch.
https://patchwork.kernel.org/patch/2852163/

---
 arch/arm/boot/dts/am33xx.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 7073429..9770e35 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -453,7 +453,7 @@
 			ti,hwmods = "usb_otg_hs";
 			status = "disabled";
 
-			usb_ctrl_mod: control at 44e10000 {
+			usb_ctrl_mod: control at 44e10620 {
 				compatible = "ti,am335x-usb-ctrl-module";
 				reg = <0x44e10620 0x10
 					0x44e10648 0x4>;
@@ -556,7 +556,7 @@
 					"tx14", "tx15";
 			};
 
-			cppi41dma: dma-controller at 07402000 {
+			cppi41dma: dma-controller at 47402000 {
 				compatible = "ti,am3359-cppi41";
 				reg =  <0x47400000 0x1000
 					0x47402000 0x1000
-- 
1.9.0
