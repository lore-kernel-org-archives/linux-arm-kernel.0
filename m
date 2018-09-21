From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 21 Sep 2018 15:51:51 +0530
Subject: [RFC PATCH 36/40] arm64: dts: k3-am6: Add "socionext,
 synquacer-pre-its" property to gic_its
In-Reply-To: <20180921102155.22839-1-kishon@ti.com>
References: <20180921102155.22839-1-kishon@ti.com>
Message-ID: <20180921102155.22839-37-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GIC_ITS used in AM65x platform has the same configuration as that of
GIC_ITS used in Socionext SoCs. Add "socionext,synquacer-pre-its"
property to get PCI MSI working.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index adcd6341e40c..2df4acb198bd 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -24,6 +24,7 @@
 		gic_its: gic-its at 18200000 {
 			compatible = "arm,gic-v3-its";
 			reg = <0x00 0x01820000 0x00 0x10000>;
+			socionext,synquacer-pre-its = <0x1000000 0x400000>;
 			msi-controller;
 			#msi-cells = <1>;
 		};
-- 
2.17.1
