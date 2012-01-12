From: robherring2@gmail.com (Rob Herring)
Date: Thu, 12 Jan 2012 11:31:12 -0600
Subject: [PATCH v2 3/7] ARM: ux500: add missing ENDPROC to headsmp.S
In-Reply-To: <1326389476-11569-1-git-send-email-robherring2@gmail.com>
References: <1326389476-11569-1-git-send-email-robherring2@gmail.com>
Message-ID: <1326389476-11569-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Once the ENDPROC is in place, BSYM() in not longer necessary
to get correct pointer to u8500_secondary_startup().

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Cc: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-ux500/headsmp.S |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/headsmp.S b/arch/arm/mach-ux500/headsmp.S
index 64fa451..d03843d 100644
--- a/arch/arm/mach-ux500/headsmp.S
+++ b/arch/arm/mach-ux500/headsmp.S
@@ -32,6 +32,7 @@ pen:	ldr	r7, [r6]
 	 * should now contain the SVC stack for this core
 	 */
 	b	secondary_startup
+ENDPROC(u8500_secondary_startup)
 
 1:	.long	.
 	.long	pen_release
-- 
1.7.5.4
