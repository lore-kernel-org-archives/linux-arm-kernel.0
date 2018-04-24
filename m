From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Apr 2018 11:26:59 +0200
Subject: [PATCH] arm64: dts: renesas: r8a7795-es1: Enable IPMMU devices
Message-ID: <20180424092659.23657-1-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove 'status = "disabled"' to make sure all IPMMU devices are enabled
in DT on the r8a7795 ES1.0 Soc.

This is a follow up for a patch by Magnus Damm for the
the r8a7795 ES2.0 and other R-Car Gen 3 SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
Based on renesas-devel-20180423-v4.17-rc2
---
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
index f9acd125d687..0177f5e60e5a 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
@@ -39,7 +39,6 @@
 		reg = <0 0xe7730000 0 0x1000>;
 		renesas,ipmmu-main = <&ipmmu_mm 8>;
 		#iommu-cells = <1>;
-		status = "disabled";
 	};
 
 	/delete-node/ usb-phy at ee0e0200;
-- 
2.11.0
