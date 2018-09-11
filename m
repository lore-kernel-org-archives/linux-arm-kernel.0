From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 11 Sep 2018 11:12:50 +0100
Subject: [PATCH 09/10] ARM: shmobile: r8a7744: Basic SoC support
In-Reply-To: <1536660771-32278-1-git-send-email-biju.das@bp.renesas.com>
References: <1536660771-32278-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1536660771-32278-10-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add minimal support for the RZ/G1N (R8A7744) SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/mach-shmobile/Kconfig           | 5 +++++
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 94e9431..34aedd2 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -78,6 +78,11 @@ config ARCH_R8A7743
 	select ARCH_RCAR_GEN2
 	select ARM_ERRATA_798181 if SMP
 
+config ARCH_R8A7744
+	bool "RZ/G1N (R8A77440)"
+	select ARCH_RCAR_GEN2
+	select ARM_ERRATA_798181 if SMP
+
 config ARCH_R8A7745
 	bool "RZ/G1E (R8A77450)"
 	select ARCH_RCAR_GEN2
diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 013acc9..eea60b2 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -25,6 +25,7 @@
 static const struct of_device_id cpg_matches[] __initconst = {
 	{ .compatible = "renesas,rcar-gen2-cpg-clocks", },
 	{ .compatible = "renesas,r8a7743-cpg-mssr", .data = "extal" },
+	{ .compatible = "renesas,r8a7744-cpg-mssr", .data = "extal" },
 	{ .compatible = "renesas,r8a7790-cpg-mssr", .data = "extal" },
 	{ .compatible = "renesas,r8a7791-cpg-mssr", .data = "extal" },
 	{ .compatible = "renesas,r8a7793-cpg-mssr", .data = "extal" },
@@ -193,6 +194,7 @@ MACHINE_END
 
 static const char * const rz_g1_boards_compat_dt[] __initconst = {
 	"renesas,r8a7743",
+	"renesas,r8a7744",
 	"renesas,r8a7745",
 	"renesas,r8a77470",
 	NULL,
-- 
2.7.4
