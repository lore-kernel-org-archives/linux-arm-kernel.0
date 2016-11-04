From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 05 Nov 2016 00:49:55 +0300
Subject: [PATCH v2 03/11] ARM: shmobile: r8a7745: basic SoC support
In-Reply-To: <2368353.xfo5beGC5E@wasted.cogentembedded.com>
References: <2368353.xfo5beGC5E@wasted.cogentembedded.com>
Message-ID: <1611958.qRQu5pdJd3@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add minimal support for the RZ/G1E (R8A7745) SoC.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

---
Changes in version 2:
- added Geert's tag;
- refreshed the patch.

 Documentation/devicetree/bindings/arm/shmobile.txt |    2 ++
 arch/arm/mach-shmobile/Kconfig                     |    4 ++++
 arch/arm/mach-shmobile/setup-rcar-gen2.c           |    1 +
 3 files changed, 7 insertions(+)

Index: renesas/Documentation/devicetree/bindings/arm/shmobile.txt
===================================================================
--- renesas.orig/Documentation/devicetree/bindings/arm/shmobile.txt
+++ renesas/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -15,6 +15,8 @@ SoCs:
     compatible = "renesas,r8a7740"
   - RZ/G1M (R8A77430)
     compatible = "renesas,r8a7743"
+  - RZ/G1E (R8A77450)
+    compatible = "renesas,r8a7745"
   - R-Car M1A (R8A77781)
     compatible = "renesas,r8a7778"
   - R-Car H1 (R8A77790)
Index: renesas/arch/arm/mach-shmobile/Kconfig
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/Kconfig
+++ renesas/arch/arm/mach-shmobile/Kconfig
@@ -73,6 +73,10 @@ config ARCH_R8A7743
 	select ARCH_RCAR_GEN2
 	select ARM_ERRATA_798181 if SMP
 
+config ARCH_R8A7745
+	bool "RZ/G1E (R8A77450)"
+	select ARCH_RCAR_GEN2
+
 config ARCH_R8A7778
 	bool "R-Car M1A (R8A77781)"
 	select ARCH_RCAR_GEN1
Index: renesas/arch/arm/mach-shmobile/setup-rcar-gen2.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ renesas/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -227,6 +227,7 @@ MACHINE_END
 
 static const char * const rz_g1_boards_compat_dt[] __initconst = {
 	"renesas,r8a7743",
+	"renesas,r8a7745",
 	NULL,
 };
 
