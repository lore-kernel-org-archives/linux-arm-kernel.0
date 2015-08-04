From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 4 Aug 2015 21:00:24 +0530
Subject: [PATCH 01/10] ARM: dts: dra7: Add dt node for PCIe registers in
 sysctrl space
In-Reply-To: <1438702233-8027-1-git-send-email-kishon@ti.com>
References: <1438702233-8027-1-git-send-email-kishon@ti.com>
Message-ID: <1438702233-8027-2-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add new device tree node for the control module register space where
PCIe registers are present.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index aa6abfc..33c5655 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -154,6 +154,11 @@
 					compatible = "syscon";
 					reg = <0x1c04 0x0020>;
 				};
+
+				scm_conf2: scm_conf at 1c24 {
+					compatible = "syscon";
+					reg = <0x1c24 0x0024>;
+				};
 			};
 
 			cm_core_aon: cm_core_aon at 5000 {
-- 
1.7.9.5
