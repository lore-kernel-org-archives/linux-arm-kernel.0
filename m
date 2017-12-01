From: dinguyen@kernel.org (Dinh Nguyen)
Date: Fri,  1 Dec 2017 11:43:13 -0600
Subject: [PATCH 1/3] ARM: dts: socfpga: disable over-current for Arria10 USB
 devkit
Message-ID: <1512150195-31821-1-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The USB host functionality on the Arria10 needs the disable-over-current
property.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
index 3a32de9..64cc86a 100644
--- a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
@@ -163,6 +163,7 @@
 
 &usb0 {
 	status = "okay";
+	disable-over-current;
 };
 
 &watchdog1 {
-- 
2.7.4
