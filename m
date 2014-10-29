From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 29 Oct 2014 13:59:53 +0900
Subject: [PATCH 3/4] ARM: shmobile: ape6evm-reference: Initialise CMT1 device
 using DT
In-Reply-To: <cover.1414557047.git.horms+renesas@verge.net.au>
References: <cover.1414557047.git.horms+renesas@verge.net.au>
Message-ID: <dfb846c95e3a7bb14f3aa61473aa4be0a8fe02ab.1414557047.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initialise CMT1 device using DT when booting ape6evm
using DT-reference.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts | 4 ++++
 arch/arm/mach-shmobile/setup-r8a73a4.c          | 3 +--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
index 2bcf691..84e05f7 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
@@ -94,6 +94,10 @@
 	voltage-tolerance = <1>; /* 1% */
 };
 
+&cmt1 {
+	status = "okay";
+};
+
 &pfc {
 	scifa0_pins: serial0 {
 		renesas,groups = "scifa0_data";
diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
index 7a7df71..3b7efc0 100644
--- a/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
@@ -189,7 +189,6 @@ static struct resource cmt1_resources[] = {
 
 void __init r8a73a4_add_dt_devices(void)
 {
-	r8a73a4_register_cmt(1);
 }
 
 /* DMA */
@@ -282,7 +281,7 @@ static struct resource dma_resources[] = {
 
 void __init r8a73a4_add_standard_devices(void)
 {
-	r8a73a4_add_dt_devices();
+	r8a73a4_register_cmt(1);
 	r8a73a4_register_scif(0);
 	r8a73a4_register_scif(1);
 	r8a73a4_register_scif(2);
-- 
2.1.1
