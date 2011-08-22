From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Mon, 22 Aug 2011 16:19:53 +0200
Subject: [PATCH] cpuimx* boards: fix mach-types errors
In-Reply-To: <20110822135540.GH2287@n2100.arm.linux.org.uk>
References: <20110822135540.GH2287@n2100.arm.linux.org.uk>
Message-ID: <1314022793-7501-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I made some changes to the entry in the ARM Machine Registry after
submission which was the wrong thing to do.
This patch should help to fix this error.

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-imx/mach-cpuimx27.c        |    2 +-
 arch/arm/mach-imx/mach-cpuimx35.c        |    2 +-
 arch/arm/mach-imx/mach-eukrea_cpuimx25.c |    2 +-
 arch/arm/tools/mach-types                |    6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/mach-cpuimx27.c b/arch/arm/mach-imx/mach-cpuimx27.c
index 87887ac..f851fe9 100644
--- a/arch/arm/mach-imx/mach-cpuimx27.c
+++ b/arch/arm/mach-imx/mach-cpuimx27.c
@@ -310,7 +310,7 @@ static struct sys_timer eukrea_cpuimx27_timer = {
 	.init = eukrea_cpuimx27_timer_init,
 };
 
-MACHINE_START(CPUIMX27, "EUKREA CPUIMX27")
+MACHINE_START(EUKREA_CPUIMX27, "EUKREA CPUIMX27")
 	.boot_params = MX27_PHYS_OFFSET + 0x100,
 	.map_io = mx27_map_io,
 	.init_early = imx27_init_early,
diff --git a/arch/arm/mach-imx/mach-cpuimx35.c b/arch/arm/mach-imx/mach-cpuimx35.c
index f39a478b..4bd083b 100644
--- a/arch/arm/mach-imx/mach-cpuimx35.c
+++ b/arch/arm/mach-imx/mach-cpuimx35.c
@@ -192,7 +192,7 @@ struct sys_timer eukrea_cpuimx35_timer = {
 	.init	= eukrea_cpuimx35_timer_init,
 };
 
-MACHINE_START(EUKREA_CPUIMX35, "Eukrea CPUIMX35")
+MACHINE_START(EUKREA_CPUIMX35SD, "Eukrea CPUIMX35")
 	/* Maintainer: Eukrea Electromatique */
 	.boot_params = MX3x_PHYS_OFFSET + 0x100,
 	.map_io = mx35_map_io,
diff --git a/arch/arm/mach-imx/mach-eukrea_cpuimx25.c b/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
index da36da5..2442d5d 100644
--- a/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
+++ b/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
@@ -161,7 +161,7 @@ static struct sys_timer eukrea_cpuimx25_timer = {
 	.init   = eukrea_cpuimx25_timer_init,
 };
 
-MACHINE_START(EUKREA_CPUIMX25, "Eukrea CPUIMX25")
+MACHINE_START(EUKREA_CPUIMX25SD, "Eukrea CPUIMX25")
 	/* Maintainer: Eukrea Electromatique */
 	.boot_params = MX25_PHYS_OFFSET + 0x100,
 	.map_io = mx25_map_io,
diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
index fff68d0..62cc8f9 100644
--- a/arch/arm/tools/mach-types
+++ b/arch/arm/tools/mach-types
@@ -351,7 +351,7 @@ centro			MACH_CENTRO		CENTRO			1944
 nokia_rx51		MACH_NOKIA_RX51		NOKIA_RX51		1955
 omap_zoom2		MACH_OMAP_ZOOM2		OMAP_ZOOM2		1967
 cpuat9260		MACH_CPUAT9260		CPUAT9260		1973
-eukrea_cpuimx27		MACH_CPUIMX27		CPUIMX27		1975
+eukrea_cpuimx27		MACH_EUKREA_CPUIMX27	EUKREA_CPUIMX27		1975
 acs5k			MACH_ACS5K		ACS5K			1982
 snapper_9260		MACH_SNAPPER_9260	SNAPPER_9260		1987
 dsm320			MACH_DSM320		DSM320			1988
@@ -476,8 +476,8 @@ cns3420vb		MACH_CNS3420VB		CNS3420VB		2776
 omap4_panda		MACH_OMAP4_PANDA	OMAP4_PANDA		2791
 ti8168evm		MACH_TI8168EVM		TI8168EVM		2800
 teton_bga		MACH_TETON_BGA		TETON_BGA		2816
-eukrea_cpuimx25sd	MACH_EUKREA_CPUIMX25	EUKREA_CPUIMX25		2820
-eukrea_cpuimx35sd	MACH_EUKREA_CPUIMX35	EUKREA_CPUIMX35		2821
+eukrea_cpuimx25sd	MACH_EUKREA_CPUIMX25SD	EUKREA_CPUIMX25SD	2820
+eukrea_cpuimx35sd	MACH_EUKREA_CPUIMX35SD	EUKREA_CPUIMX35SD	2821
 eukrea_cpuimx51sd	MACH_EUKREA_CPUIMX51SD	EUKREA_CPUIMX51SD	2822
 eukrea_cpuimx51		MACH_EUKREA_CPUIMX51	EUKREA_CPUIMX51		2823
 smdkc210		MACH_SMDKC210		SMDKC210		2838
-- 
1.7.6
