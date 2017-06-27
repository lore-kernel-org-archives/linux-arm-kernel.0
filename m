From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 27 Jun 2017 20:36:11 +0530
Subject: [PATCH 2/3] ARM: dts: dra72-evm-revc: workaround incorrect DP83867
 RX_CTRL pin strap
In-Reply-To: <cover.1498573382.git.nsekhar@ti.com>
References: <cover.1498573382.git.nsekhar@ti.com>
Message-ID: <f534218be6ade8f0f54c9897840116ad8238cdd0.1498573382.git.nsekhar@ti.com>
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
 arch/arm/boot/dts/dra72-evm-revc.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dra72-evm-revc.dts b/arch/arm/boot/dts/dra72-evm-revc.dts
index 5532309971ae..9b439851ff79 100644
--- a/arch/arm/boot/dts/dra72-evm-revc.dts
+++ b/arch/arm/boot/dts/dra72-evm-revc.dts
@@ -80,6 +80,7 @@
 		ti,min-output-impedance;
 		interrupt-parent = <&gpio6>;
 		interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
+		ti,dp83867-rxctrl-strap-quirk;
 	};
 
 	dp83867_1: ethernet-phy at 3 {
@@ -90,6 +91,7 @@
 		ti,min-output-impedance;
 		interrupt-parent = <&gpio6>;
 		interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
+		ti,dp83867-rxctrl-strap-quirk;
 	};
 };
 
-- 
2.9.0
