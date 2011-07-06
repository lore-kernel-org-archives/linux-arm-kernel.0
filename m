From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:46:56 -0400
Subject: [PATCH 11/52] ARM: mach-h720x: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-11-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The value used for boot_params in h7201-eval.c is nonsensical, given that
PLAT_PHYS_OFFSET is defined to 0x40000000.  Left unchanged to purposely
break the build to get its maintainer's attention.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-h720x/h7202-eval.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-h720x/h7202-eval.c b/arch/arm/mach-h720x/h7202-eval.c
index 884584a..284a134 100644
--- a/arch/arm/mach-h720x/h7202-eval.c
+++ b/arch/arm/mach-h720x/h7202-eval.c
@@ -71,7 +71,7 @@ static void __init init_eval_h7202(void)
 
 MACHINE_START(H7202, "Hynix HMS30C7202")
 	/* Maintainer: Robert Schwebel, Pengutronix */
-	.boot_params	= 0x40000100,
+	.atag_offset	= 0x100,
 	.map_io		= h720x_map_io,
 	.init_irq	= h7202_init_irq,
 	.timer		= &h7202_timer,
-- 
1.7.4
