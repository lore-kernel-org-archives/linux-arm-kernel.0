From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 1 Aug 2016 16:42:28 +0530
Subject: [PATCH v2 1/3] ARM: dts: DRA7: Add "linux,
 pci-domain" property for pci dt nodes
In-Reply-To: <1470049950-4697-1-git-send-email-kishon@ti.com>
References: <1470049950-4697-1-git-send-email-kishon@ti.com>
Message-ID: <1470049950-4697-2-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since DRA7 has multiple PCIe Rootcomplex, add "linux,pci-domain"
property to assign a PCI domain number to each of the host
bridges.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 40b69a5..45e9d2d 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -301,6 +301,7 @@
 					  0x82000000 0 0x20013000 0x13000 0 0xffed000>;
 				#interrupt-cells = <1>;
 				num-lanes = <1>;
+				linux,pci-domain = <0>;
 				ti,hwmods = "pcie1";
 				phys = <&pcie1_phy>;
 				phy-names = "pcie-phy0";
@@ -336,6 +337,7 @@
 					  0x82000000 0 0x30013000 0x13000 0 0xffed000>;
 				#interrupt-cells = <1>;
 				num-lanes = <1>;
+				linux,pci-domain = <1>;
 				ti,hwmods = "pcie2";
 				phys = <&pcie2_phy>;
 				phy-names = "pcie-phy0";
-- 
1.7.9.5
