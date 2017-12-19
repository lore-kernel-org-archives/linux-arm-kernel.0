From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 19 Dec 2017 15:01:27 +0530
Subject: [PATCH 1/7] ARM: dts: dra7: Add properties to enable PCIe x2 lane mode
In-Reply-To: <20171219093133.16565-1-kishon@ti.com>
References: <20171219093133.16565-1-kishon@ti.com>
Message-ID: <20171219093133.16565-2-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ti,syscon-lane-sel and ti,syscon-lane-conf properties specific to enable
PCIe x2 lane mode are added here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index ac9216293b7c..9966d82dbd7c 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -309,6 +309,8 @@
 				ti,hwmods = "pcie1";
 				phys = <&pcie1_phy>;
 				phy-names = "pcie-phy0";
+				ti,syscon-lane-conf = <&scm_conf 0x558>;
+				ti,syscon-lane-sel = <&scm_conf_pcie 0x18>;
 				interrupt-map-mask = <0 0 0 7>;
 				interrupt-map = <0 0 0 1 &pcie1_intc 1>,
 						<0 0 0 2 &pcie1_intc 2>,
@@ -334,6 +336,8 @@
 				phys = <&pcie1_phy>;
 				phy-names = "pcie-phy0";
 				ti,syscon-unaligned-access = <&scm_conf1 0x14 2>;
+				ti,syscon-lane-conf = <&scm_conf 0x558>;
+				ti,syscon-lane-sel = <&scm_conf_pcie 0x18>;
 				status = "disabled";
 			};
 		};
-- 
2.11.0
