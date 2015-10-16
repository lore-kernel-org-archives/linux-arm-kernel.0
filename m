From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 16 Oct 2015 12:39:05 +0200
Subject: [PATCH] ARM: at91: pm: at91_pm_suspend_in_sram() must be 8-byte
 aligned
Message-ID: <1444991945-7946-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrick Doyle <pdoyle@irobot.com>

fncpy() requires that the source and the destination are both 8-byte
aligned.

Signed-off-by: Patrick Doyle <pdoyle@irobot.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/pm_suspend.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index 0d95f488b47a..a25defda3d22 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -80,6 +80,8 @@ tmp2	.req	r5
  *	@r2: base address of second SDRAM Controller or 0 if not present
  *	@r3: pm information
  */
+/* at91_pm_suspend_in_sram must be 8-byte aligned per the requirements of fncpy() */
+	.align 3
 ENTRY(at91_pm_suspend_in_sram)
 	/* Save registers on stack */
 	stmfd	sp!, {r4 - r12, lr}
-- 
2.1.4
