From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 19 May 2017 13:45:17 +0530
Subject: [PATCH 17/41] ARM: dts: dra72-evm: Add vmmc_aux supply to mmc1
In-Reply-To: <20170519081541.26753-1-kishon@ti.com>
References: <20170519081541.26753-1-kishon@ti.com>
Message-ID: <20170519081541.26753-18-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add vmmc_aux-supply property to mmc1 dt node and populate
it with ldo1_reg to reflect ldo1_out is connected to mmc1 IO lines.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra72-evm.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index cd9c4ff12654..1c570236a1a0 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -43,3 +43,7 @@
 	phy_id = <&davinci_mdio>, <3>;
 	phy-mode = "rgmii";
 };
+
+&mmc1 {
+	vmmc_aux-supply = <&ldo1_reg>;
+};
-- 
2.11.0
