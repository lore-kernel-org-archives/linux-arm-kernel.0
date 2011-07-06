From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:46:58 -0400
Subject: [PATCH 13/52] ARM: mach-integrator: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-13-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-integrator/integrator_ap.c |    2 +-
 arch/arm/mach-integrator/integrator_cp.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index 2fbbdd5..eaa95bd 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -457,7 +457,7 @@ static struct sys_timer ap_timer = {
 
 MACHINE_START(INTEGRATOR, "ARM-Integrator")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.reserve	= integrator_reserve,
 	.map_io		= ap_map_io,
 	.init_early	= integrator_init_early,
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 4eb03ab..5de49c3 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -492,7 +492,7 @@ static struct sys_timer cp_timer = {
 
 MACHINE_START(CINTEGRATOR, "ARM-IntegratorCP")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.reserve	= integrator_reserve,
 	.map_io		= intcp_map_io,
 	.init_early	= intcp_init_early,
-- 
1.7.4
