From: joel@jms.id.au (Joel Stanley)
Date: Wed,  4 Oct 2017 17:19:15 +1030
Subject: [PATCH v2 7/9] ARM: dts: aspeed: Add aliases for UARTs
In-Reply-To: <20171004064917.2498-1-joel@jms.id.au>
References: <20171004064917.2498-1-joel@jms.id.au>
Message-ID: <20171004064917.2498-8-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Existing userspace expects the console (UART5) to be at /dev/ttyS4.  To
ensure the UARTs show up where users expect them, we give them fixed
aliases starting at 0.

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts | 4 ----
 arch/arm/boot/dts/aspeed-g4.dtsi              | 5 +++++
 arch/arm/boot/dts/aspeed-g5.dtsi              | 5 +++++
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
index e387c80b7f4f..be51be5a5f39 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
@@ -6,10 +6,6 @@
 	model = "Palmetto BMC";
 	compatible = "tyan,palmetto-bmc", "aspeed,ast2400";
 
-	aliases {
-		serial4 = &uart5;
-	};
-
 	chosen {
 		stdout-path = &uart5;
 		bootargs = "console=ttyS4,115200 earlyprintk";
diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index b6ae7b62fd03..a549413bda3f 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -22,6 +22,11 @@
 		i2c11 = &i2c11;
 		i2c12 = &i2c12;
 		i2c13 = &i2c13;
+		serial0 = &uart1;
+		serial1 = &uart2;
+		serial2 = &uart3;
+		serial3 = &uart4;
+		serial4 = &uart5;
 	};
 
 	cpus {
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 4c829e915c3e..de2dafa71651 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -22,6 +22,11 @@
 		i2c11 = &i2c11;
 		i2c12 = &i2c12;
 		i2c13 = &i2c13;
+		serial0 = &uart1;
+		serial1 = &uart2;
+		serial2 = &uart3;
+		serial3 = &uart4;
+		serial4 = &uart5;
 	};
 
 	cpus {
-- 
2.14.1
