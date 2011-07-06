From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:46:59 -0400
Subject: [PATCH 14/52] ARM: mach-iop13xx: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-14-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-iop13xx/iq81340mc.c |    2 +-
 arch/arm/mach-iop13xx/iq81340sc.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-iop13xx/iq81340mc.c b/arch/arm/mach-iop13xx/iq81340mc.c
index 9b5a63f5..5e99e92 100644
--- a/arch/arm/mach-iop13xx/iq81340mc.c
+++ b/arch/arm/mach-iop13xx/iq81340mc.c
@@ -91,7 +91,7 @@ static struct sys_timer iq81340mc_timer = {
 
 MACHINE_START(IQ81340MC, "Intel IQ81340MC")
 	/* Maintainer: Dan Williams <dan.j.williams@intel.com> */
-	.boot_params    = 0x00000100,
+	.atag_offset    = 0x100,
 	.map_io         = iop13xx_map_io,
 	.init_irq       = iop13xx_init_irq,
 	.timer          = &iq81340mc_timer,
diff --git a/arch/arm/mach-iop13xx/iq81340sc.c b/arch/arm/mach-iop13xx/iq81340sc.c
index df3492a..cd9e274 100644
--- a/arch/arm/mach-iop13xx/iq81340sc.c
+++ b/arch/arm/mach-iop13xx/iq81340sc.c
@@ -93,7 +93,7 @@ static struct sys_timer iq81340sc_timer = {
 
 MACHINE_START(IQ81340SC, "Intel IQ81340SC")
 	/* Maintainer: Dan Williams <dan.j.williams@intel.com> */
-	.boot_params    = 0x00000100,
+	.atag_offset    = 0x100,
 	.map_io         = iop13xx_map_io,
 	.init_irq       = iop13xx_init_irq,
 	.timer          = &iq81340sc_timer,
-- 
1.7.4
