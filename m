From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:18:02 +0200
Subject: [PATCH 04/14] ARM: shmobile: r8a77470: basic SoC support
In-Reply-To: <cover.1526639075.git.horms+renesas@verge.net.au>
References: <cover.1526639075.git.horms+renesas@verge.net.au>
Message-ID: <0c1d543b75f242f08b08e7fb63a1df2ada025903.1526639075.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

Add minimal support for the RZ/G1C (R8A77470) SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
 arch/arm/mach-shmobile/Kconfig                     | 4 ++++
 arch/arm/mach-shmobile/setup-rcar-gen2.c           | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index d3d1df97834f..86ac320323a7 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -21,6 +21,8 @@ SoCs:
     compatible = "renesas,r8a7744"
   - RZ/G1E (R8A77450)
     compatible = "renesas,r8a7745"
+  - RZ/G1C (R8A77470)
+    compatible = "renesas,r8a77470"
   - R-Car M1A (R8A77781)
     compatible = "renesas,r8a7778"
   - R-Car H1 (R8A77790)
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 280e7312a9e1..6b9111455a30 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -75,6 +75,10 @@ config ARCH_R8A7745
 	bool "RZ/G1E (R8A77450)"
 	select ARCH_RCAR_GEN2
 
+config ARCH_R8A77470
+	bool "RZ/G1C (R8A77470)"
+	select ARCH_RCAR_GEN2
+
 config ARCH_R8A7778
 	bool "R-Car M1A (R8A77781)"
 	select ARCH_RCAR_GEN1
diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 5561dbed7a33..80de6be912e1 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -73,6 +73,7 @@ void __init rcar_gen2_timer_init(void)
 	shmobile_init_cntvoff();
 
 	if (of_machine_is_compatible("renesas,r8a7745") ||
+	    of_machine_is_compatible("renesas,r8a77470") ||
 	    of_machine_is_compatible("renesas,r8a7792") ||
 	    of_machine_is_compatible("renesas,r8a7794")) {
 		freq = 260000000 / 8;	/* ZS / 8 */
@@ -205,6 +206,7 @@ MACHINE_END
 static const char * const rz_g1_boards_compat_dt[] __initconst = {
 	"renesas,r8a7743",
 	"renesas,r8a7745",
+	"renesas,r8a77470",
 	NULL,
 };
 
-- 
2.11.0
