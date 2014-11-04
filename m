From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  4 Nov 2014 10:50:48 +0900
Subject: [PATCH 18/34] ARM: shmobile: bockw-reference: Initialise TMU device
 using DT
In-Reply-To: <cover.1415059587.git.horms+renesas@verge.net.au>
References: <cover.1415059587.git.horms+renesas@verge.net.au>
Message-ID: <18b27aeb5591588de35628bf1e423abf24fe9695.1415059587.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initialise TMU device using DT when booting bockw
using DT-reference.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778-bockw-reference.dts | 4 ++++
 arch/arm/mach-shmobile/setup-r8a7778.c        | 3 +--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7778-bockw-reference.dts b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
index fba2949..04c0c37 100644
--- a/arch/arm/boot/dts/r8a7778-bockw-reference.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
@@ -74,6 +74,10 @@
 	status = "okay";
 };
 
+&tmu0 {
+	status = "okay";
+};
+
 &pfc {
 	scif0_pins: serial0 {
 		renesas,groups = "scif0_data_a", "scif0_ctrl";
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 8ec784f..7c7223d 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -288,8 +288,6 @@ void __init r8a7778_add_dt_devices(void)
 		l2x0_init(base, 0x00400000, 0xc20f0fff);
 	}
 #endif
-
-	r8a7778_register_tmu(0);
 }
 
 /* HPB-DMA */
@@ -497,6 +495,7 @@ static void __init r8a7778_register_hpb_dmae(void)
 void __init r8a7778_add_standard_devices(void)
 {
 	r8a7778_add_dt_devices();
+	r8a7778_register_tmu(0);
 	r8a7778_register_scif(0);
 	r8a7778_register_scif(1);
 	r8a7778_register_scif(2);
-- 
2.1.1
