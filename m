From: anup.patel@broadcom.com (Anup Patel)
Date: Tue, 29 Mar 2016 12:57:31 +0530
Subject: [PATCH 1/4] arm64: dts: Add ARM PL330 DMA DT node for NS2
In-Reply-To: <1459236454-26285-1-git-send-email-anup.patel@broadcom.com>
References: <1459236454-26285-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1459236454-26285-2-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have one ARM PL330 DMA instance with 8 channels in
NS2 SoC. Let's enable it for NS2 in NS2 DT.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Pramod KUMAR <pramodku@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/ns2.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
index 6f81c9d..a9f4585 100644
--- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
@@ -217,6 +217,25 @@
 		#size-cells = <1>;
 		ranges = <0 0 0 0xffffffff>;
 
+		dma0: dma at 61360000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x61360000 0x1000>;
+			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
+			clocks = <&iprocslow>;
+			clock-names = "apb_pclk";
+		};
+
 		smmu: mmu at 64000000 {
 			compatible = "arm,mmu-500";
 			reg = <0x64000000 0x40000>;
-- 
1.9.1
