From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 9 Aug 2017 19:32:48 +0530
Subject: [PATCH v2 2/3] ARM: dts: dra72-evm-revc: workaround incorrect DP83867
 RX_CTRL pin strap
In-Reply-To: <cover.1502284400.git.nsekhar@ti.com>
References: <cover.1502284400.git.nsekhar@ti.com>
Message-ID: <a96549250204b80373ebf58abeed1c67441e6fb8.1502284400.git.nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DRA72 EVM Rev C straps the DP83867 GigaBit Ethernet phy's RX_DV/RX_CTRL
pin in mode 1. Unfortunately, the phy data manual disallows this.

Add "ti,dp83867-rxctrl-strap-quirk" property to the phy's device-tree node
to allow kernel to enable software workaround for this incorrect strap
setting. This is as suggested by the phy's datamanual and ensures proper
operation of this PHY.

This needs to be done for both instances of this PHY present on the board.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/dra72-evm-revc.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/dra72-evm-revc.dts b/arch/arm/boot/dts/dra72-evm-revc.dts
index 3ecac56bf504..be18bc023c3f 100644
--- a/arch/arm/boot/dts/dra72-evm-revc.dts
+++ b/arch/arm/boot/dts/dra72-evm-revc.dts
@@ -70,6 +70,7 @@
 		ti,min-output-impedance;
 		interrupt-parent = <&gpio6>;
 		interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
+		ti,dp83867-rxctrl-strap-quirk;
 	};
 
 	dp83867_1: ethernet-phy at 3 {
@@ -80,5 +81,7 @@
 		ti,min-output-impedance;
 		interrupt-parent = <&gpio6>;
 		interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
+		ti,dp83867-rxctrl-strap-quirk;
 	};
 };
+
-- 
2.9.0
