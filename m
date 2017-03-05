From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Mon,  6 Mar 2017 07:31:35 +0800
Subject: [PATCH v7 3/6] ARM: dts: sun8i: correct the GIC compatible in H3 to
 gic-400
In-Reply-To: <20170305233138.64574-1-icenowy@aosc.xyz>
References: <20170305233138.64574-1-icenowy@aosc.xyz>
Message-ID: <20170305233138.64574-4-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the datasheets provided by Allwinner, both Allwinner H3 and
H5 use GIC-400 as their interrupt controller.

For better device tree reusing, correct the GIC compatible in H3 DTSI to
"arm,gic-400", thus this node can be reused in H5.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
New patch extracted in v7.

 arch/arm/boot/dts/sun8i-h3.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index b250e6d03b57..c13fbfb92592 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -586,7 +586,7 @@
 		};
 
 		gic: interrupt-controller at 01c81000 {
-			compatible = "arm,cortex-a7-gic", "arm,cortex-a15-gic";
+			compatible = "arm,gic-400";
 			reg = <0x01c81000 0x1000>,
 			      <0x01c82000 0x2000>,
 			      <0x01c84000 0x2000>,
-- 
2.11.1
