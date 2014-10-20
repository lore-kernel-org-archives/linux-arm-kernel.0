From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Mon, 20 Oct 2014 16:20:44 +0300
Subject: [PATCH 2/2] ARM: dts: k2l-mvm: add 1g ethernet phys nodes
In-Reply-To: <1413811244-4041-1-git-send-email-grygorii.strashko@ti.com>
References: <1413811244-4041-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <1413811244-4041-2-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keystone K2L-EVM has two 1G Marvell 88E1514 Ethernet PHYs
installed, which are compatible with 88E1510.
Hence, add corresponding child nodes for 1G MDIO bus.

For more information see:
  https://www.einfochips.com/index.php/partnerships/texas-instruments/k2l-evm.html

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/boot/dts/k2l-evm.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/k2l-evm.dts b/arch/arm/boot/dts/k2l-evm.dts
index fec4312..85cc7f2 100644
--- a/arch/arm/boot/dts/k2l-evm.dts
+++ b/arch/arm/boot/dts/k2l-evm.dts
@@ -116,3 +116,15 @@
 		};
 	};
 };
+
+&mdio {
+	ethphy0: ethernet-phy at 0 {
+		compatible = "marvell,88E1514", "marvell,88E1510", "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+	};
+
+	ethphy1: ethernet-phy at 1 {
+		compatible = "marvell,88E1514", "marvell,88E1510", "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+	};
+};
-- 
1.9.1
