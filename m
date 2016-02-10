From: anup.patel@broadcom.com (Anup Patel)
Date: Wed, 10 Feb 2016 11:40:50 +0530
Subject: [PATCH 5/6] arm64: dts: Add ARM SP805 watchdog DT node for NS2
In-Reply-To: <1455084651-29325-1-git-send-email-anup.patel@broadcom.com>
References: <1455084651-29325-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1455084651-29325-6-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have one ARM SP805 watchdog instance on NS2 for non-secure software
hence this patch adds appropriate watchdog DT node in NS2 DT.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Pramod KUMAR <pramodku@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/ns2.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
index 83e1c27..062616b4 100644
--- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
@@ -306,6 +306,14 @@
 			status = "disabled";
 		};
 
+		wdt0: watchdog at 66090000 {
+			compatible = "arm,sp805", "arm,primecell";
+			reg = <0x66090000 0x1000>;
+			interrupts = <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&iprocslow>, <&iprocslow>;
+			clock-names = "wdogclk", "apb_pclk";
+		};
+
 		i2c1: i2c at 660b0000 {
 			compatible = "brcm,iproc-i2c";
 			reg = <0x660b0000 0x100>;
-- 
1.9.1
