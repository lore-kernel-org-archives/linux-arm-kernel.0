From: linux@prisktech.co.nz (Tony Prisk)
Date: Sat, 13 Oct 2012 17:18:02 +1300
Subject: [PATCH for 3.7] dtb: fix interrupt assignment for ehci/uhci on wm8505
Message-ID: <1350101882-6195-1-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

EHCI and UHCI devices in wm8505.dtsi should use IRQ 0 & 1
respectively - not 43 as used on newer models.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 arch/arm/boot/dts/wm8505.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/wm8505.dtsi b/arch/arm/boot/dts/wm8505.dtsi
index b459691..330f833 100644
--- a/arch/arm/boot/dts/wm8505.dtsi
+++ b/arch/arm/boot/dts/wm8505.dtsi
@@ -71,13 +71,13 @@
 		ehci at d8007100 {
 			compatible = "via,vt8500-ehci";
 			reg = <0xd8007100 0x200>;
-			interrupts = <43>;
+			interrupts = <1>;
 		};
 
 		uhci at d8007300 {
 			compatible = "platform-uhci";
 			reg = <0xd8007300 0x200>;
-			interrupts = <43>;
+			interrupts = <0>;
 		};
 
 		fb at d8050800 {
-- 
1.7.9.5
