From: ran.wang_1@nxp.com (Ran Wang)
Date: Wed, 5 Jul 2017 03:15:19 +0000
Subject: [PATCH] arm64: dts: ls1046a: Add dis_rxdet_inp3_quirk property to
 USB3 node
In-Reply-To: <1496370600-31442-1-git-send-email-ran.wang_1@nxp.com>
References: <1496370600-31442-1-git-send-email-ran.wang_1@nxp.com>
Message-ID: <AM3PR04MB1489D79BAAC1C8AC3823BDB1F1D40@AM3PR04MB1489.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sir,
    How is the review result of this patch. I am waiting for it be merged, thanks.

BR
Ran

-----Original Message-----
From: Ran Wang [mailto:ran.wang_1 at nxp.com] 
Sent: Friday, June 02, 2017 10:30 AM
To: Rob Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Catalin Marinas <catalin.marinas@arm.com>; Will Deacon <will.deacon@arm.com>
Cc: Shawn Guo <shawnguo@kernel.org>; Andy Tang <andy.tang@nxp.com>; Horia Geant? <horia.geanta@nxp.com>; Marc Zyngier <marc.zyngier@arm.com>; Mihai Emilian Bantea <mihai.bantea@nxp.com>; Jia Hongtao <hongtao.jia@nxp.com>; Scott Wood <oss@buserror.net>; Gang Liu <gang.liu@nxp.com>; york sun <york.sun@nxp.com>; open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>; moderated list:ARM64 PORT (AARCH64 ARCHITECTURE) <linux-arm-kernel@lists.infradead.org>; open list <linux-kernel@vger.kernel.org>; Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH] arm64: dts: ls1046a: Add dis_rxdet_inp3_quirk property to USB3 node

Add "dis_rxdet_inp3_quirk" boolean property to USB3 node. This property is used to disable rx detection in P3 PHY mode.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index f4b8b7e..9137280 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -567,6 +567,7 @@
 			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
+			snps,dis_rxdet_inp3_quirk;
 		};
 
 		usb1: usb at 3000000 {
@@ -575,6 +576,7 @@
 			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
+			snps,dis_rxdet_inp3_quirk;
 		};
 
 		usb2: usb at 3100000 {
@@ -583,6 +585,7 @@
 			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
+			snps,dis_rxdet_inp3_quirk;
 		};
 
 		sata: sata at 3200000 {
--
2.1.0.27.g96db324
