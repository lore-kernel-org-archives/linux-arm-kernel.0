From: steven.lin1@broadcom.com (Steve Lin)
Date: Thu, 23 Feb 2017 09:49:51 -0500
Subject: [PATCH v2 2/3] ARM: dts: NSP: Add mailbox (PDC) to NSP
In-Reply-To: <1487861392-23039-1-git-send-email-steven.lin1@broadcom.com>
References: <1487861392-23039-1-git-send-email-steven.lin1@broadcom.com>
Message-ID: <1487861392-23039-3-git-send-email-steven.lin1@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds mailbox / PDC to NSP device tree.  Needs new compatibility string
to differentiate from NS2 version.

Signed-off-by: Steve Lin <steven.lin1@broadcom.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 15f07f9..8b56d74 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -227,6 +227,15 @@
 			status = "disabled";
 		};
 
+		mailbox: mailbox at 25000 {
+			compatible = "brcm,iproc-fa2-mbox";
+			reg = <0x25000 0x445>;
+			interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <1>;
+			brcm,rx-status-len = <32>;
+			brcm,use-bcm-hdr;
+		};
+
 		nand: nand at 26000 {
 			compatible = "brcm,nand-iproc", "brcm,brcmnand-v6.1";
 			reg = <0x026000 0x600>,
-- 
2.1.0
