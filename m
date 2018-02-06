From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 6 Feb 2018 18:28:06 +0530
Subject: [PATCH v2 15/15] ARM: dts: dra7: Add high speed modes capability to
 MMC1/MMC2 dt node
In-Reply-To: <20180206125806.19350-1-kishon@ti.com>
References: <20180206125806.19350-1-kishon@ti.com>
Message-ID: <20180206125806.19350-16-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add UHS/HS200/DDR speed mode capability to MMC1 and MMC2 dt nodes.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 7bf33d522b14..feb496e7c5ef 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1073,7 +1073,13 @@
 			status = "disabled";
 			pbias-supply = <&pbias_mmc_reg>;
 			max-frequency = <192000000>;
+			sd-uhs-sdr104;
+			sd-uhs-sdr50;
+			sd-uhs-ddr50;
+			sd-uhs-sdr25;
+			sd-uhs-sdr12;
 			cap-sd-highspeed;
+			mmc-ddr-1_8v;
 			cap-mmc-highspeed;
 		};
 
@@ -1092,6 +1098,10 @@
 			status = "disabled";
 			max-frequency = <192000000>;
 			cap-sd-highspeed;
+			sd-uhs-sdr25;
+			sd-uhs-sdr12;
+			mmc-hs200-1_8v;
+			mmc-ddr-1_8v;
 			cap-mmc-highspeed;
 		};
 
-- 
2.11.0
