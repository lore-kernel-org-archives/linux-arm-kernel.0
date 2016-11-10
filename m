From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 10 Nov 2016 01:09:53 +0100
Subject: [PATCH 07/14] ARM: dts: armada-375: Fixup pcie DT warnings
In-Reply-To: <20161110001000.10619-1-gregory.clement@free-electrons.com>
References: <20161110001000.10619-1-gregory.clement@free-electrons.com>
Message-ID: <20161110001000.10619-8-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PCIe has a range property, so the unit name should contain an address.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-375.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index c832ebb40ac4..700d80fe0d85 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -580,7 +580,7 @@
 			};
 		};
 
-		pciec: pcie-controller {
+		pciec: pcie-controller at 82000000@ {
 			compatible = "marvell,armada-370-pcie";
 			status = "disabled";
 			device_type = "pci";
-- 
2.10.1
