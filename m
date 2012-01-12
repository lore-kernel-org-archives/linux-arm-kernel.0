From: robherring2@gmail.com (Rob Herring)
Date: Thu, 12 Jan 2012 11:31:11 -0600
Subject: [PATCH v2 2/7] ARM: msm: Add missing ENDPROC to headsmp.S
In-Reply-To: <1326389476-11569-1-git-send-email-robherring2@gmail.com>
References: <1326389476-11569-1-git-send-email-robherring2@gmail.com>
Message-ID: <1326389476-11569-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Once the ENDPROC is in place, BSYM() in not longer necessary
to get correct pointer to msm_secondary_startup().

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: David Brown <davidb@codeaurora.org>
Cc: Daniel Walker <dwalker@fifo99.com>
---
 arch/arm/mach-msm/headsmp.S |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-msm/headsmp.S b/arch/arm/mach-msm/headsmp.S
index 0c631a9..bcd5af2 100644
--- a/arch/arm/mach-msm/headsmp.S
+++ b/arch/arm/mach-msm/headsmp.S
@@ -34,6 +34,7 @@ pen:	ldr	r7, [r6]
 	 * should now contain the SVC stack for this core
 	 */
 	b	secondary_startup
+ENDPROC(msm_secondary_startup)
 
 	.align
 1:	.long	.
-- 
1.7.5.4
