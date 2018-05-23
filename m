From: scott.branden@broadcom.com (Scott Branden)
Date: Wed, 23 May 2018 13:17:10 -0700
Subject: [PATCH] arm64: dts: stingray: Add otp device node
Message-ID: <1527106630-4760-1-git-send-email-scott.branden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add otp device node for Stingray SOC.

Fixes: 2fa9e9e29ea2 ("arm64: dts: Add GPIO DT nodes for Stingray SOC")
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index 99aaff0..6013478 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -258,6 +258,13 @@
 
 		#include "stingray-clock.dtsi"
 
+		otp: otp at 1c400 {
+			compatible = "brcm,ocotp-v2";
+			reg = <0x0001c400 0x68>;
+			brcm,ocotp-size = <2048>;
+			status = "okay";
+		};
+
 		gpio_crmu: gpio at 24800 {
 			compatible = "brcm,iproc-gpio";
 			reg = <0x00024800 0x4c>;
-- 
2.5.0
