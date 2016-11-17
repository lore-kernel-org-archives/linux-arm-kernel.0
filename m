From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Nov 2016 14:34:45 +0100
Subject: [PATCH 1/2] ARM: shmobile: r8a7745: basic SoC support
In-Reply-To: <cover.1479387356.git.horms+renesas@verge.net.au>
References: <cover.1479387356.git.horms+renesas@verge.net.au>
Message-ID: <47802fd7c7c4735ddaf004e0f61371dcaa86f4ad.1479387356.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Add minimal support for the RZ/G1E (R8A7745) SoC.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
 arch/arm/mach-shmobile/Kconfig                     | 4 ++++
 arch/arm/mach-shmobile/setup-rcar-gen2.c           | 1 +
 3 files changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 9a60cb38cf56..0af01f9a01f4 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -15,6 +15,8 @@ SoCs:
     compatible = "renesas,r8a7740"
   - RZ/G1M (R8A77430)
     compatible = "renesas,r8a7743"
+  - RZ/G1E (R8A77450)
+    compatible = "renesas,r8a7745"
   - R-Car M1A (R8A77781)
     compatible = "renesas,r8a7778"
   - R-Car H1 (R8A77790)
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 6fbd9b7d2d67..f0b5e7dfa6d0 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
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
diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index d6b4841e51a9..14c1f0ed2ecb 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -235,6 +235,7 @@ MACHINE_END
 
 static const char * const rz_g1_boards_compat_dt[] __initconst = {
 	"renesas,r8a7743",
+	"renesas,r8a7745",
 	NULL,
 };
 
-- 
2.7.0.rc3.207.g0ac5344
