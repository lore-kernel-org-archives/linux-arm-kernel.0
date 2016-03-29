From: anup.patel@broadcom.com (Anup Patel)
Date: Tue, 29 Mar 2016 12:57:32 +0530
Subject: [PATCH 2/4] arm64: dts: Add maintenance interrupt for GIC in NS2 DT
In-Reply-To: <1459236454-26285-1-git-send-email-anup.patel@broadcom.com>
References: <1459236454-26285-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1459236454-26285-3-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The KVM ARM64 requires GIC maintenance interrupt for VGIC emulation
so this patch adds the missing "interrupts" attribute to GIC node in
NS2 DT.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/ns2.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
index a9f4585..940ed52 100644
--- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
@@ -347,6 +347,8 @@
 			      <0x65220000 0x1000>,
 			      <0x65240000 0x2000>,
 			      <0x65260000 0x1000>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_RAW(0xf) |
+				      IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
 		timer0: timer at 66030000 {
-- 
1.9.1
