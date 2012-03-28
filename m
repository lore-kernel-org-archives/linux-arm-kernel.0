From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 28 Mar 2012 11:49:47 +0100
Subject: [PATCH] ARM: ux500: fix compile error in new timer code
Message-ID: <1332931787-27741-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the errors below:

error: implicit declaration of function ?pr_err?
error: implicit declaration of function ?BUG?

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/timer.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/timer.c b/arch/arm/mach-ux500/timer.c
index e9d5807..21ec778 100644
--- a/arch/arm/mach-ux500/timer.c
+++ b/arch/arm/mach-ux500/timer.c
@@ -4,6 +4,8 @@
  * License Terms: GNU General Public License v2
  * Author: Mattias Wallin <mattias.wallin@stericsson.com> for ST-Ericsson
  */
+#include <linux/kernel.h>
+#include <linux/bug.h>
 #include <linux/io.h>
 #include <linux/errno.h>
 #include <linux/clksrc-dbx500-prcmu.h>
-- 
1.7.5.4
