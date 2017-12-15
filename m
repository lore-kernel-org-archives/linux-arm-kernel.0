From: joel@jms.id.au (Joel Stanley)
Date: Fri, 15 Dec 2017 16:54:34 +1030
Subject: [PATCH v2 10/19] ARM: dts: aspeed: Add LPC Snoop device
In-Reply-To: <20171215062443.23059-1-joel@jms.id.au>
References: <20171215062443.23059-1-joel@jms.id.au>
Message-ID: <20171215062443.23059-11-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

LPC snoop hardware on the ASPEED BMC, used for monitoring
host I/O port activity.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 7 +++++++
 arch/arm/boot/dts/aspeed-g5.dtsi | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index f6fee40c04c0..b3580f37f507 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -236,6 +236,13 @@
 						status = "disabled";
 					};
 
+					lpc_snoop: lpc-snoop at 0 {
+						compatible = "aspeed,ast2500-lpc-snoop";
+						reg = <0x0 0x80>;
+						interrupts = <8>;
+						status = "disabled";
+					};
+
 					lhc: lhc at 20 {
 						compatible = "aspeed,ast2500-lhc";
 						reg = <0x20 0x24 0x48 0x8>;
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 96a9d2fe3f0d..50766f0629f8 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -287,6 +287,12 @@
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
2.14.1
