From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Mon,  7 Aug 2017 10:30:05 +1200
Subject: [PATCH 2/3] ARM: dts: mvebu: set reduced-width property for SDRAM on
 98dx3236
In-Reply-To: <20170806223006.14231-1-chris.packham@alliedtelesis.co.nz>
References: <20170806223006.14231-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <20170806223006.14231-3-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because the 98dx3236 and similar SoCs are switch chips with integrated
CPUs they use a reduced pin count for the SDRAM interface. As such
"full" with is 32-bits and "half" width is 16-bits (as opposed to 64/32
on the discrete SoC). Set the reduced-width property on the sdramc node
to indicate this.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
index 0e12816d961e..4d6a2acc1b55 100644
--- a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
+++ b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
@@ -129,6 +129,7 @@
 			sdramc at 1400 {
 				compatible = "marvell,armada-xp-sdram-controller";
 				reg = <0x1400 0x500>;
+				marvell,reduced-width;
 			};
 
 			L2: l2-cache at 8000 {
-- 
2.13.0
