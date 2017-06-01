From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 1 Jun 2017 20:03:57 +0530
Subject: [PATCH 3/7] ARM: dts: dra72-evm-revc: Add vmmc_aux supply to mmc1
In-Reply-To: <20170601143401.16852-1-kishon@ti.com>
References: <20170601143401.16852-1-kishon@ti.com>
Message-ID: <20170601143401.16852-4-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add vmmc_aux-supply property to mmc1 dt node and populate
it with ldo1_reg to reflect ldo1_out is connected to mmc1 IO lines.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra72-evm-revc.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/dra72-evm-revc.dts b/arch/arm/boot/dts/dra72-evm-revc.dts
index 47dcd527ec58..40a399735533 100644
--- a/arch/arm/boot/dts/dra72-evm-revc.dts
+++ b/arch/arm/boot/dts/dra72-evm-revc.dts
@@ -93,6 +93,10 @@
 	};
 };
 
+&mmc1 {
+	vmmc_aux-supply = <&ldo1_reg>;
+};
+
 &mmc2 {
 	vmmc-supply = <&evm_1v8_sw>;
 };
-- 
2.11.0
