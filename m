From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Tue, 18 Oct 2016 16:50:19 +0530
Subject: [PATCH v4 3/4] ARM: dts: dra72-evm-revc: add phy impedance settings
In-Reply-To: <20161018112020.30273-1-mugunthanvnm@ti.com>
References: <20161018112020.30273-1-mugunthanvnm@ti.com>
Message-ID: <20161018112020.30273-4-mugunthanvnm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The default impedance settings of the phy is not the optimal
value, due to this the second ethernet is not working. Fix it
with correct values which makes the second ethernet port to work.

Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
---
 arch/arm/boot/dts/dra72-evm-revc.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dra72-evm-revc.dts b/arch/arm/boot/dts/dra72-evm-revc.dts
index 064b322..5450367 100644
--- a/arch/arm/boot/dts/dra72-evm-revc.dts
+++ b/arch/arm/boot/dts/dra72-evm-revc.dts
@@ -62,6 +62,7 @@
 		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
 		ti,tx-internal-delay = <DP83867_RGMIIDCTL_1_NS>;
 		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_8_B_NIB>;
+		ti,min-output-impedance;
 	};
 
 	dp83867_1: ethernet-phy at 3 {
@@ -69,5 +70,6 @@
 		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
 		ti,tx-internal-delay = <DP83867_RGMIIDCTL_1_NS>;
 		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_8_B_NIB>;
+		ti,min-output-imepdance;
 	};
 };
-- 
2.10.1.445.g3cdd5d1
