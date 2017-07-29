From: abhishek.shah@broadcom.com (Abhishek Shah)
Date: Sat, 29 Jul 2017 10:12:23 +0530
Subject: [PATCH 1/7] arm64: dts: Enable stats for CCN-502 interconnect on
 Stingray
In-Reply-To: <1501303349-30007-1-git-send-email-abhishek.shah@broadcom.com>
References: <1501303349-30007-1-git-send-email-abhishek.shah@broadcom.com>
Message-ID: <1501303349-30007-2-git-send-email-abhishek.shah@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Velibor Markovski <velibor.markovski@broadcom.com>

This patch enables stats for CCN-502 interconnect on Stingray.

Signed-off-by: Velibor Markovski <velibor.markovski@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index 49933cf..a63c465 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -152,6 +152,12 @@
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x61000000 0x05000000>;
 
+		ccn: ccn at 00000000 {
+			compatible = "arm,ccn-502";
+			reg = <0x00000000 0x900000>;
+			interrupts = <GIC_SPI 799 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		gic: interrupt-controller at 02c00000 {
 			compatible = "arm,gic-v3";
 			#interrupt-cells = <3>;
-- 
2.7.4
