From: s-anna@ti.com (Suman Anna)
Date: Tue, 24 Jun 2014 20:04:49 -0500
Subject: [PATCH 3/9] ARM: dts: AM4372: Correct mailbox node data
In-Reply-To: <1403658295-54766-1-git-send-email-s-anna@ti.com>
References: <1403658295-54766-1-git-send-email-s-anna@ti.com>
Message-ID: <1403658295-54766-4-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mailbox DT node for AM4372 has been corrected to include
the correct compatible flag, and remove the other properties
that have crept in by mistake.

Fixes: 9e3269b (ARM: dts: AM4372: Add L2, EDMA, mailbox, MMC and SHAM nodes)
Cc: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 49fa596..390cbb53 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -162,15 +162,10 @@
 		};
 
 		mailbox: mailbox at 480C8000 {
-			compatible = "ti,omap4-mailbox";
+			compatible = "ti,am4372-mailbox";
 			reg = <0x480C8000 0x200>;
 			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mailbox";
-			ti,mbox-num-users = <4>;
-			ti,mbox-num-fifos = <8>;
-			ti,mbox-names = "wkup_m3";
-			ti,mbox-data = <0 0 0 0>;
-			status = "disabled";
 		};
 
 		timer1: timer at 44e31000 {
-- 
2.0.0
