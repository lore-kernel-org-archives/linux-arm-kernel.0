From: zhengsq@rock-chips.com (Shunqian Zheng)
Date: Wed,  8 Jun 2016 21:26:29 +0800
Subject: [PATCH v2 4/7] ARM: dts: rockchip: add virtual iommu for display
In-Reply-To: <1465392392-2003-1-git-send-email-zhengsq@rock-chips.com>
References: <1465392392-2003-1-git-send-email-zhengsq@rock-chips.com>
Message-ID: <1465392392-2003-5-git-send-email-zhengsq@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An virtual iommu without reg or interrupts for display.
Adding this according to iommu driver changes.

Signed-off-by: Shunqian Zheng <zhengsq@rock-chips.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 7fa932f..4cd535f 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -219,9 +219,15 @@
 		clock-names = "timer", "pclk";
 	};
 
+	display_mmu: virtual-iommu {
+		compatible = "rockchip,iommu";
+		#iommu-cells = <0>;
+	};
+
 	display-subsystem {
 		compatible = "rockchip,display-subsystem";
 		ports = <&vopl_out>, <&vopb_out>;
+		iommus = <&display_mmu>;
 	};
 
 	sdmmc: dwmmc at ff0c0000 {
-- 
1.9.1
