From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 21 Dec 2015 14:43:18 +0530
Subject: [PATCH v4 1/4] ARM: dts: dra7: Add dt node for the sycon pcie
In-Reply-To: <1450689201-16973-1-git-send-email-kishon@ti.com>
References: <1450689201-16973-1-git-send-email-kishon@ti.com>
Message-ID: <1450689201-16973-2-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add new device tree node for the control module register space where
PCIe registers are present.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index fe99231..9ab7b6a 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -155,6 +155,11 @@
 					compatible = "syscon";
 					reg = <0x1c04 0x0020>;
 				};
+
+				scm_conf_pcie: scm_conf at 1c24 {
+					compatible = "syscon";
+					reg = <0x1c24 0x0024>;
+				};
 			};
 
 			cm_core_aon: cm_core_aon at 5000 {
-- 
1.7.9.5
