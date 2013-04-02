From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Apr 2013 14:09:10 +0900
Subject: [PATCH 02/28] sh: sh7269: Fix compilation by adding missing includes
In-Reply-To: <1364879376-10020-1-git-send-email-horms+renesas@verge.net.au>
References: <1364879376-10020-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364879376-10020-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

struct resource is defined in linux/ioport.h. Include it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c b/arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c
index 1825b0b..4c17fb6 100644
--- a/arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c
+++ b/arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c
@@ -9,7 +9,9 @@
  * for more details.
  */
 
+#include <linux/bug.h>
 #include <linux/init.h>
+#include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <cpu/pfc.h>
 
-- 
1.7.10.4
