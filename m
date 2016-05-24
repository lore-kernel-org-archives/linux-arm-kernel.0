From: rob.rice@broadcom.com (Rob Rice)
Date: Tue, 24 May 2016 14:07:30 -0400
Subject: [PATCH 3/3] arm64: dts: Add Broadcom Northstar2 device tree entries
 for PDC driver.
In-Reply-To: <1464113250-15629-1-git-send-email-rob.rice@broadcom.com>
References: <1464113250-15629-1-git-send-email-rob.rice@broadcom.com>
Message-ID: <1464113250-15629-4-git-send-email-rob.rice@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Rice <rrice@broadcom.com>

Add Broadcom Northstar2 SoC device tree entries for PDC driver.

Signed-off-by: Rob Rice <rob.rice@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/ns2.dtsi | 36 +++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
index ec68ec1..ba12702 100644
--- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
@@ -191,6 +191,42 @@
 
 		#include "ns2-clock.dtsi"
 
+		pdc0: iproc-pdc0 at 612c0000 {
+			compatible = "brcm,iproc-pdc-mbox";
+			reg = <0x612c0000 0x445>;  /* PDC FS0 regs */
+			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <1>;
+			brcm,rx-status-len = <32>;
+			brcm,use-bcm-hdr;
+		};
+
+		pdc1: iproc-pdc1 at 612e0000 {
+			compatible = "brcm,iproc-pdc-mbox";
+			reg = <0x612e0000 0x445>;  /* PDC FS1 regs */
+			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <1>;
+			brcm,rx-status-len = <32>;
+			brcm,use-bcm-hdr;
+		};
+
+		pdc2: iproc-pdc2 at 61300000 {
+			compatible = "brcm,iproc-pdc-mbox";
+			reg = <0x61300000 0x445>;  /* PDC FS2 regs */
+			interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <1>;
+			brcm,rx-status-len = <32>;
+			brcm,use-bcm-hdr;
+		};
+
+		pdc3: iproc-pdc3 at 61320000 {
+			compatible = "brcm,iproc-pdc-mbox";
+			reg = <0x61320000 0x445>;  /* PDC FS3 regs */
+			interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <1>;
+			brcm,rx-status-len = <32>;
+			brcm,use-bcm-hdr;
+		};
+
 		dma0: dma at 61360000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x61360000 0x1000>;
-- 
2.1.0
