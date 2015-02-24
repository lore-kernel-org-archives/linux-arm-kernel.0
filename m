From: robertcnelson@gmail.com (Robert Nelson)
Date: Tue, 24 Feb 2015 10:10:43 -0600
Subject: [PATCH] ARM: dts: am335x-bone*: usb0 is hardwired for peripheral
Message-ID: <1424794243-23394-1-git-send-email-robertcnelson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes: http://bugs.elinux.org/issues/127

the bb.org community was seeing random reboots before this change.

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index 6cc25ed..2c6248d 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -195,6 +195,7 @@
 
 &usb0 {
 	status = "okay";
+	dr_mode = "peripheral";
 };
 
 &usb1 {
-- 
2.1.4
