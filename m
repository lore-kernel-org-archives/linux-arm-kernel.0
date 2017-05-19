From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 19 May 2017 13:45:37 +0530
Subject: [PATCH 37/41] ARM: dts: am57xx-beagle-x15-common: Set MMC2 IO voltage
 to 3.3V
In-Reply-To: <20170519081541.26753-1-kishon@ti.com>
References: <20170519081541.26753-1-kishon@ti.com>
Message-ID: <20170519081541.26753-38-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MMC2 interface on AM57xx Beagle-x15, connected to
onboard eMMC, has IO voltage fixed to 3.3V.

Add no-1-8-v device-tree property to mmc2 node
in the board's device-tree file to reflect
this.

Note that the AM57xx SoC itself supports dual-voltage
on MMC2. The limitation above is due to the board.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
index 064755e6fac5..8cef5d1460ec 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
@@ -445,6 +445,7 @@
 	bus-width = <8>;
 	ti,non-removable;
 	cap-mmc-dual-data-rate;
+	no-1-8-v;
 };
 
 &sata {
-- 
2.11.0
