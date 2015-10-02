From: anup.patel@broadcom.com (Anup Patel)
Date: Fri, 2 Oct 2015 23:24:19 +0530
Subject: [PATCH 2/6] arm64: dts: Add SMMU DT node for NS2
In-Reply-To: <1443808463-21120-1-git-send-email-anup.patel@broadcom.com>
References: <1443808463-21120-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1443808463-21120-3-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SMMU-500 driver is already available in Linux kernel. Let's
enable it for NS2 in DT.

This patch keeps mmu-masters attribute empty so that driver patches
can later extend this attribute when adding device DT nodes.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/ns2.dtsi | 41 +++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
index f759175..c5d90e4 100644
--- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
@@ -103,6 +103,47 @@
 		#size-cells = <1>;
 		ranges = <0 0 0 0xffffffff>;
 
+		smmu: mmu at 64000000 {
+			compatible = "arm,mmu-500";
+			reg = <0x64000000 0x40000>;
+			#global-interrupts = <2>;
+			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 230 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 236 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 237 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 242 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 250 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 253 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>;
+			mmu-masters;
+		};
+
 		gic: interrupt-controller at 65210000 {
 			compatible = "arm,gic-400";
 			#interrupt-cells = <3>;
-- 
1.9.1
