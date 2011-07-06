From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:47:01 -0400
Subject: [PATCH 16/52] ARM: mach-iop33x: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-16-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-iop33x/iq80331.c |    2 +-
 arch/arm/mach-iop33x/iq80332.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-iop33x/iq80331.c b/arch/arm/mach-iop33x/iq80331.c
index c565f8d..2ef2e37 100644
--- a/arch/arm/mach-iop33x/iq80331.c
+++ b/arch/arm/mach-iop33x/iq80331.c
@@ -141,7 +141,7 @@ static void __init iq80331_init_machine(void)
 
 MACHINE_START(IQ80331, "Intel IQ80331")
 	/* Maintainer: Intel Corp. */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.map_io		= iop3xx_map_io,
 	.init_irq	= iop33x_init_irq,
 	.timer		= &iq80331_timer,
diff --git a/arch/arm/mach-iop33x/iq80332.c b/arch/arm/mach-iop33x/iq80332.c
index 36a9efb..56838b5 100644
--- a/arch/arm/mach-iop33x/iq80332.c
+++ b/arch/arm/mach-iop33x/iq80332.c
@@ -141,7 +141,7 @@ static void __init iq80332_init_machine(void)
 
 MACHINE_START(IQ80332, "Intel IQ80332")
 	/* Maintainer: Intel Corp. */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.map_io		= iop3xx_map_io,
 	.init_irq	= iop33x_init_irq,
 	.timer		= &iq80332_timer,
-- 
1.7.4
