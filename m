From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 30 Jul 2015 13:43:37 +0530
Subject: [PATCH 4/7] ARM: dts: dra7-evm: Add MMCSD card removal GPIO
In-Reply-To: <1438244020-4244-1-git-send-email-kishon@ti.com>
References: <1438244020-4244-1-git-send-email-kishon@ti.com>
Message-ID: <1438244020-4244-5-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nishanth Menon <nm@ti.com>

SDMMC Card Detect can be used over default GPIO map.

Reported-by: Yan Liu <yan-liu@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 1e0c88e..25f0a00 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -474,6 +474,11 @@
 	vmmc-supply = <&evm_3v3_sd>;
 	vmmc_aux-supply = <&ldo1_reg>;
 	bus-width = <4>;
+	/*
+	 * SDCD signal is not being used here - using the fact that GPIO mode
+	 * is always hardwired.
+	 */
+	cd-gpios = <&gpio6 27 0>;
 };
 
 &mmc2 {
-- 
1.7.9.5
