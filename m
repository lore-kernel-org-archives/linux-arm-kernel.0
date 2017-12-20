From: joel@jms.id.au (Joel Stanley)
Date: Wed, 20 Dec 2017 13:53:18 +1030
Subject: [PATCH v3 10/20] ARM: dts: aspeed: Add LPC Snoop device
In-Reply-To: <20171220032328.30584-1-joel@jms.id.au>
References: <20171220032328.30584-1-joel@jms.id.au>
Message-ID: <20171220032328.30584-11-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

LPC snoop hardware on the ASPEED BMC, used for monitoring
host I/O port activity.

Reviewed-by: C?dric Le Goater <clg@kaod.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 7 +++++++
 arch/arm/boot/dts/aspeed-g5.dtsi | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 91aea96c10c8..e8a61fc3956d 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -237,6 +237,13 @@
 						status = "disabled";
 					};
 
+					lpc_snoop: lpc-snoop at 0 {
+						compatible = "aspeed,ast2400-lpc-snoop";
+						reg = <0x0 0x80>;
+						interrupts = <8>;
+						status = "disabled";
+					};
+
 					lhc: lhc at 20 {
 						compatible = "aspeed,ast2400-lhc";
 						reg = <0x20 0x24 0x48 0x8>;
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index af3869ec87bb..d558091aa92b 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -288,6 +288,12 @@
 						status = "disabled";
 					};
 
+					lpc_snoop: lpc-snoop at 0 {
+						compatible = "aspeed,ast2500-lpc-snoop";
+						reg = <0x0 0x80>;
+						interrupts = <8>;
+						status = "disabled";
+					};
 
 					lhc: lhc at 20 {
 						compatible = "aspeed,ast2500-lhc";
-- 
2.15.1
