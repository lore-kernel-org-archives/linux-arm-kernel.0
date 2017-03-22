From: robh@kernel.org (Rob Herring)
Date: Tue, 21 Mar 2017 21:02:59 -0500
Subject: [PATCH 01/15] ARM: dts: alpine: fix PCIe node name
Message-ID: <20170322020313.24338-1-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PCIe bridges should have a node name of 'pcie'.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Tsahee Zidenberg <tsahee@annapurnalabs.com>
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>
---
Sub-arch maintainers, please apply to your trees unless arm-soc wants 
to take the whole lot.

 arch/arm/boot/dts/alpine.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/alpine.dtsi b/arch/arm/boot/dts/alpine.dtsi
index d0eefc3b886c..f09f9c8e178a 100644
--- a/arch/arm/boot/dts/alpine.dtsi
+++ b/arch/arm/boot/dts/alpine.dtsi
@@ -139,7 +139,7 @@
 		};
 
 		/* Internal PCIe Controller */
-		pcie-internal at 0xfbc00000 {
+		pcie at fbc00000 {
 			compatible = "pci-host-ecam-generic";
 			device_type = "pci";
 			#size-cells = <2>;
-- 
2.10.1
