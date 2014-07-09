From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 9 Jul 2014 16:14:19 +0300
Subject: [PATCH 2/3] ARM: dts: keystone-evm: add 1g ethernet phys nodes
In-Reply-To: <1404911660-10047-1-git-send-email-grygorii.strashko@ti.com>
References: <1404911660-10047-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <1404911660-10047-3-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keystone EVMK2HX has two 1G Marvell 88E1111 Ethernet PHYs
installed, so add corresponding child nodes for 1G MDIO bus
and enable it.

For more information see schematics:
 http://wfcache.advantech.com/www/support/TI-EVM/download/Schematics/PDF/K2H_K2EVM-HK_SCH_A102_Rev1_0.pdf

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/boot/dts/k2hk-evm.dts |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/k2hk-evm.dts b/arch/arm/boot/dts/k2hk-evm.dts
index 1f90cbf..3223cc1 100644
--- a/arch/arm/boot/dts/k2hk-evm.dts
+++ b/arch/arm/boot/dts/k2hk-evm.dts
@@ -167,3 +167,15 @@
 		};
 	};
 };
+
+&mdio {
+	ethphy0: ethernet-phy at 0 {
+		compatible = "marvell,88E1111", "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+	};
+
+	ethphy1: ethernet-phy at 1 {
+		compatible = "marvell,88E1111", "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+	};
+};
-- 
1.7.9.5
