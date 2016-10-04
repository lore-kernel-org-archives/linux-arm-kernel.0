From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Tue, 4 Oct 2016 18:26:07 +0530
Subject: [PATCH v2 4/4] ARM: dts: dra72-evm-revc: fix correct phy delay
In-Reply-To: <20161004125607.10569-1-mugunthanvnm@ti.com>
References: <20161004125607.10569-1-mugunthanvnm@ti.com>
Message-ID: <20161004125607.10569-5-mugunthanvnm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current delay settings of the phy are not the optimal value,
fix it with correct values.

Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
---
 arch/arm/boot/dts/dra72-evm-revc.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/dra72-evm-revc.dts b/arch/arm/boot/dts/dra72-evm-revc.dts
index d626cd7..8472a8c 100644
--- a/arch/arm/boot/dts/dra72-evm-revc.dts
+++ b/arch/arm/boot/dts/dra72-evm-revc.dts
@@ -59,16 +59,16 @@
 &davinci_mdio {
 	dp83867_0: ethernet-phy at 2 {
 		reg = <2>;
-		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
-		ti,tx-internal-delay = <DP83867_RGMIIDCTL_1_NS>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
+		ti,tx-internal-delay = <DP83867_RGMIIDCTL_250_PS>;
 		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_8_B_NIB>;
 		ti,min-output-imepdance;
 	};
 
 	dp83867_1: ethernet-phy at 3 {
 		reg = <3>;
-		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
-		ti,tx-internal-delay = <DP83867_RGMIIDCTL_1_NS>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
+		ti,tx-internal-delay = <DP83867_RGMIIDCTL_250_PS>;
 		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_8_B_NIB>;
 		ti,min-output-imepdance;
 	};
-- 
2.10.0.372.g6fe1b14
