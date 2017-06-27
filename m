From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 27 Jun 2017 20:36:10 +0530
Subject: [PATCH 1/3] ARM: dts: dra71-evm: workaround incorrect DP83867 RX_CTRL
 pin strap
In-Reply-To: <cover.1498573382.git.nsekhar@ti.com>
References: <cover.1498573382.git.nsekhar@ti.com>
Message-ID: <d283da02e13907f87d9b05a605f4114a95524255.1498573382.git.nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DRA71 EVM straps the DP83867 GigaBit Ethernet phy's RX_DV/RX_CTRL pin
in mode 1. Unfortunately, the phy data manual disallows this.

Add "ti,dp83867-rxctrl-strap-quirk" property to the phy's device-tree node
to allow kernel to enable software workaround for this incorrect strap
setting. This is as suggested by the phy's datamanual and ensures proper
operation of this PHY.

This needs to be done for both instances of this PHY present on the board.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/dra71-evm.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dra71-evm.dts b/arch/arm/boot/dts/dra71-evm.dts
index 570f06e4f71f..c1a7ee09218f 100644
--- a/arch/arm/boot/dts/dra71-evm.dts
+++ b/arch/arm/boot/dts/dra71-evm.dts
@@ -205,6 +205,7 @@
 		ti,tx-internal-delay = <DP83867_RGMIIDCTL_250_PS>;
 		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_8_B_NIB>;
 		ti,min-output-impedance;
+		ti,dp83867-rxctrl-strap-quirk;
 	};
 
 	dp83867_1: ethernet-phy at 3 {
@@ -213,6 +214,7 @@
 		ti,tx-internal-delay = <DP83867_RGMIIDCTL_250_PS>;
 		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_8_B_NIB>;
 		ti,min-output-impedance;
+		ti,dp83867-rxctrl-strap-quirk;
 	};
 };
 
-- 
2.9.0
