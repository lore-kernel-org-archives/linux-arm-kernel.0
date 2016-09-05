From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 5 Sep 2016 11:19:48 +1000
Subject: linux-next: manual merge of the samsung-krzk tree with the arm-soc
 tree
Message-ID: <20160905111948.553487be@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

Today's linux-next merge of the samsung-krzk tree got a conflict in:

  arch/arm64/boot/dts/exynos/exynos7.dtsi

between commit:

  585dcacac6bb ("arm64: dts: Fix broken architected timer interrupt trigger")

from the arm-soc tree and commit:

  36d1c9cd07cd ("arm64: dts: exynos: Use human-friendly symbols for timer interrupt flags")

from the samsung-krzk tree.

I fixed it up (I *think* - see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc arch/arm64/boot/dts/exynos/exynos7.dtsi
index 162831546e18,8d7ce97c0ddb..000000000000
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@@ -473,10 -474,14 +474,14 @@@
  
  		timer {
  			compatible = "arm,armv8-timer";
- 			interrupts = <1 13 0xff08>,
- 				     <1 14 0xff08>,
- 				     <1 11 0xff08>,
- 				     <1 10 0xff08>;
+ 			interrupts = <GIC_PPI 13
 -					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_EDGE_RISING)>,
++					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+ 				     <GIC_PPI 14
 -					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_EDGE_RISING)>,
++					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+ 				     <GIC_PPI 11
 -					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_EDGE_RISING)>,
++					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+ 				     <GIC_PPI 10
 -					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_EDGE_RISING)>;
++					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
  		};
  
  		pmu_system_controller: system-controller at 105c0000 {
