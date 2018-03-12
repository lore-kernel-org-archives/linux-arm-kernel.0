From: dinguyen@kernel.org (Dinh Nguyen)
Date: Mon, 12 Mar 2018 09:55:26 -0500
Subject: [PATCH] arm64: dts: stratix10: disable false USB overcurrent on devkit
Message-ID: <1520866526-28650-1-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Disable the USB overcurrent condition that is falsely detected on the
devkit.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index 95f8669..7644ddc 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -117,6 +117,7 @@
 
 &usb0 {
 	status = "okay";
+	disable-over-current;
 };
 
 &i2c1 {
-- 
2.7.4
