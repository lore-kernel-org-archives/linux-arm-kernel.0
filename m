From: jitendra.bhivare@broadcom.com (Jitendra Bhivare)
Date: Tue,  7 Aug 2018 14:37:04 +0530
Subject: [PATCH 1/1] arm64: dts: Stingray: Adjust SMMU non-secure context
 interrupt
Message-ID: <1533632824-17436-1-git-send-email-jitendra.bhivare@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pramod Kumar <pramod.kumar@broadcom.com>

One context bank has been reserved for secure master, CRMU.
hence need to remove context interrupt accordingly. Doing
the same in this patch.

Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index b203152..7fcaf38 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -244,8 +244,7 @@
 				     <GIC_SPI 770 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 771 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 772 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 773 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 774 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 773 IRQ_TYPE_LEVEL_HIGH>;
 			#iommu-cells = <2>;
 		};
 	};
-- 
2.7.4
