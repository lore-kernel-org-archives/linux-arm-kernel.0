From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 29 Feb 2016 15:16:24 +1100
Subject: linux-next: manual merge of the iommu tree with the arm-soc tree
Message-ID: <20160229151624.338cef0e@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

Today's linux-next merge of the iommu tree got a conflict in:

  arch/arm64/boot/dts/mediatek/mt8173.dtsi

between commit:

  93e9f5ee1e35 ("dts: arm64: Add EFUSE device node")

from the arm-soc tree and commit:

  5ff6b3a6d391 ("dts: mt8173: Add iommu/smi nodes for mt8173")

from the iommu tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell

diff --cc arch/arm64/boot/dts/mediatek/mt8173.dtsi
index f4bd3c9182ad,804881181fcc..000000000000
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@@ -277,11 -278,17 +278,22 @@@
  			reg = <0 0x10200620 0 0x20>;
  		};
  
+ 		iommu: iommu at 10205000 {
+ 			compatible = "mediatek,mt8173-m4u";
+ 			reg = <0 0x10205000 0 0x1000>;
+ 			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_LOW>;
+ 			clocks = <&infracfg CLK_INFRA_M4U>;
+ 			clock-names = "bclk";
+ 			mediatek,larbs = <&larb0 &larb1 &larb2
+ 					  &larb3 &larb4 &larb5>;
+ 			#iommu-cells = <1>;
+ 		};
+ 
 +		efuse: efuse at 10206000 {
 +			compatible = "mediatek,mt8173-efuse";
 +			reg = <0 0x10206000 0 0x1000>;
 +		};
 +
  		apmixedsys: clock-controller at 10209000 {
  			compatible = "mediatek,mt8173-apmixedsys";
  			reg = <0 0x10209000 0 0x1000>;
