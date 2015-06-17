From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 17 Jun 2015 14:12:20 +0200
Subject: [PATCH RESEND 3/4] ARM: mvebu: remove unneeded dmacap,
 * properties in Device Trees
In-Reply-To: <1434543141-3242-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1434543141-3242-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1434543141-3242-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dmacap,* properties are now ignored by the mv_xor driver, who
knows what are the capabilities of the hardware. For the DMA_XOR and
DMA_MEMCPY capabilities, there are no changes: they were anyway
mentionned in all DTs. The DMA_MEMSET operation (enabled by
dmacap,memset) was ignored since the removal of DMA_MEMSET support
from mv_xor. Also, now the DMA_INTERRUPT capability is enabled for all
SoCs.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
Note: this patch should only be applied once 'dmaengine: mv_xor:
remove support for dmacap,* DT properties' is applied.
---
 arch/arm/boot/dts/armada-370.dtsi | 10 ----------
 arch/arm/boot/dts/armada-375.dtsi | 10 ----------
 arch/arm/boot/dts/armada-38x.dtsi | 10 ----------
 arch/arm/boot/dts/armada-39x.dtsi | 10 ----------
 arch/arm/boot/dts/armada-xp.dtsi  | 10 ----------
 arch/arm/boot/dts/dove.dtsi       |  8 --------
 6 files changed, 58 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 00b50db5..cb68579 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -278,14 +278,9 @@
 
 				xor00 {
 					interrupts = <51>;
-					dmacap,memcpy;
-					dmacap,xor;
 				};
 				xor01 {
 					interrupts = <52>;
-					dmacap,memcpy;
-					dmacap,xor;
-					dmacap,memset;
 				};
 			};
 
@@ -297,14 +292,9 @@
 
 				xor10 {
 					interrupts = <94>;
-					dmacap,memcpy;
-					dmacap,xor;
 				};
 				xor11 {
 					interrupts = <95>;
-					dmacap,memcpy;
-					dmacap,xor;
-					dmacap,memset;
 				};
 			};
 		};
diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index f076ff8..ebee84a 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -476,14 +476,9 @@
 
 				xor00 {
 					interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
-					dmacap,memcpy;
-					dmacap,xor;
 				};
 				xor01 {
 					interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
-					dmacap,memcpy;
-					dmacap,xor;
-					dmacap,memset;
 				};
 			};
 
@@ -496,14 +491,9 @@
 
 				xor10 {
 					interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
-					dmacap,memcpy;
-					dmacap,xor;
 				};
 				xor11 {
 					interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
-					dmacap,memcpy;
-					dmacap,xor;
-					dmacap,memset;
 				};
 			};
 
diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 218a2ac..1710523 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -456,14 +456,9 @@
 
 				xor00 {
 					interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
-					dmacap,memcpy;
-					dmacap,xor;
 				};
 				xor01 {
 					interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
-					dmacap,memcpy;
-					dmacap,xor;
-					dmacap,memset;
 				};
 			};
 
@@ -476,14 +471,9 @@
 
 				xor10 {
 					interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
-					dmacap,memcpy;
-					dmacap,xor;
 				};
 				xor11 {
 					interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
-					dmacap,memcpy;
-					dmacap,xor;
-					dmacap,memset;
 				};
 			};
 
diff --git a/arch/arm/boot/dts/armada-39x.dtsi b/arch/arm/boot/dts/armada-39x.dtsi
index ecd1318..9c510d8 100644
--- a/arch/arm/boot/dts/armada-39x.dtsi
+++ b/arch/arm/boot/dts/armada-39x.dtsi
@@ -331,14 +331,9 @@
 
 				xor00 {
 					interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
-					dmacap,memcpy;
-					dmacap,xor;
 				};
 				xor01 {
 					interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
-					dmacap,memcpy;
-					dmacap,xor;
-					dmacap,memset;
 				};
 			};
 
@@ -351,14 +346,9 @@
 
 				xor10 {
 					interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
-					dmacap,memcpy;
-					dmacap,xor;
 				};
 				xor11 {
 					interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
-					dmacap,memcpy;
-					dmacap,xor;
-					dmacap,memset;
 				};
 			};
 
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 013d63f..9c46054 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -209,14 +209,9 @@
 
 				xor10 {
 					interrupts = <51>;
-					dmacap,memcpy;
-					dmacap,xor;
 				};
 				xor11 {
 					interrupts = <52>;
-					dmacap,memcpy;
-					dmacap,xor;
-					dmacap,memset;
 				};
 			};
 
@@ -229,14 +224,9 @@
 
 				xor00 {
 					interrupts = <94>;
-					dmacap,memcpy;
-					dmacap,xor;
 				};
 				xor01 {
 					interrupts = <95>;
-					dmacap,memcpy;
-					dmacap,xor;
-					dmacap,memset;
 				};
 			};
 		};
diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 9ad8295..e71c552 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -261,14 +261,10 @@
 
 				channel0 {
 					interrupts = <39>;
-					dmacap,memcpy;
-					dmacap,xor;
 				};
 
 				channel1 {
 					interrupts = <40>;
-					dmacap,memcpy;
-					dmacap,xor;
 				};
 			};
 
@@ -281,14 +277,10 @@
 
 				channel0 {
 					interrupts = <42>;
-					dmacap,memcpy;
-					dmacap,xor;
 				};
 
 				channel1 {
 					interrupts = <43>;
-					dmacap,memcpy;
-					dmacap,xor;
 				};
 			};
 
-- 
2.1.0
