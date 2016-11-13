From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sun, 13 Nov 2016 22:32:28 +0100
Subject: [PATCH v2 07/13] ARM: dts: armada-375: Fixup pcie DT warnings
In-Reply-To: <20161113213234.3368-1-gregory.clement@free-electrons.com>
References: <20161113213234.3368-1-gregory.clement@free-electrons.com>
Message-ID: <20161113213234.3368-8-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PCIe has a range property, so the unit name should contain an address.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-375.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index ba9d7d64221c..4824a4c1883c 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -580,7 +580,7 @@
 			};
 		};
 
-		pciec: pcie-controller {
+		pciec: pcie-controller at 82000000 {
 			compatible = "marvell,armada-370-pcie";
 			status = "disabled";
 			device_type = "pci";
-- 
2.10.2
