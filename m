From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  7 Jul 2014 09:54:31 +0200
Subject: [PATCH v2 06/30] ARM: shmobile: bockw-reference: Initialise TMU
 device using DT
In-Reply-To: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
References: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1404719695-1634-7-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initialise TMU device using DT when booting bockw
using DT-reference.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2
* Added Ack from Laurent Pinchart
---
 arch/arm/boot/dts/r8a7778-bockw-reference.dts | 4 ++++
 arch/arm/mach-shmobile/setup-r8a7778.c        | 3 +--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7778-bockw-reference.dts b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
index 3342c74..970237c 100644
--- a/arch/arm/boot/dts/r8a7778-bockw-reference.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
@@ -73,6 +73,10 @@
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
index e218c46..575148d 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -293,8 +293,6 @@ void __init r8a7778_add_dt_devices(void)
 		l2x0_init(base, 0x00400000, 0xc20f0fff);
 	}
 #endif
-
-	r8a7778_register_tmu(0);
 }
 
 /* HPB-DMA */
@@ -502,6 +500,7 @@ static void __init r8a7778_register_hpb_dmae(void)
 void __init r8a7778_add_standard_devices(void)
 {
 	r8a7778_add_dt_devices();
+	r8a7778_register_tmu(0);
 	r8a7778_register_scif(0);
 	r8a7778_register_scif(1);
 	r8a7778_register_scif(2);
-- 
2.0.0.rc2
