From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 20 Jul 2015 16:42:20 +0530
Subject: [PATCH] ARM: dts: am437x: add aliases for all UART instances
Message-ID: <b1af39962d1cae5c344e8593ca738c825af40955.1437390674.git.nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add serialN aliases for all 6 UART instances on
the AM437x SoC so each board's .dts file does not
have to define its own aliases.

Remove the alias added for am437x-gp-evm.dts now
that we have the aliases defined in am4372.dtsi
file.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi       | 5 +++++
 arch/arm/boot/dts/am437x-gp-evm.dts | 1 -
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index ade28c790f4b..7eb43a4f6176 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -23,6 +23,11 @@
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
 		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+		serial5 = &uart5;
 		ethernet0 = &cpsw_emac0;
 		ethernet1 = &cpsw_emac1;
 	};
diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 84aa30c3235a..f435dc9b44ca 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -21,7 +21,6 @@
 
 	aliases {
 		display0 = &lcd0;
-		serial3 = &uart3;
 	};
 
 	vmmcsd_fixed: fixedregulator-sd {
-- 
2.4.4.408.g16da57c
