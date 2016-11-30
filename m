From: rob.rice@broadcom.com (Rob Rice)
Date: Wed, 30 Nov 2016 15:07:33 -0500
Subject: [PATCH 3/3] crypto: brcm: Add Broadcom SPU driver DT entry.
In-Reply-To: <1480536453-24781-1-git-send-email-rob.rice@broadcom.com>
References: <1480536453-24781-1-git-send-email-rob.rice@broadcom.com>
Message-ID: <1480536453-24781-4-git-send-email-rob.rice@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Northstar2 device tree entry for Broadcom Secure Processing
Unit (SPU) crypto driver.

Signed-off-by: Steve Lin <steven.lin1@broadcom.com>
Signed-off-by: Rob Rice <rob.rice@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/ns2.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
index d95dc40..8b81b0d 100644
--- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
@@ -191,6 +191,18 @@

 		#include "ns2-clock.dtsi"

+		spu-crypto at 612d0000 {
+			compatible = "brcm,spum-crypto";
+			reg = <0x612d0000 0x900>,    /* SPU 0 control regs */
+				<0x612f0000 0x900>,  /* SPU 1 control regs */
+				<0x61310000 0x900>,  /* SPU 2 control regs */
+				<0x61330000 0x900>;  /* SPU 3 control regs */
+			mboxes = <&pdc0 0>,
+				<&pdc1 0>,
+				<&pdc2 0>,
+				<&pdc3 0>;
+		};
+
 		dma0: dma at 61360000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x61360000 0x1000>;
--
2.1.0
