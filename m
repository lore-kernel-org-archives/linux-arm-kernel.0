From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 22:02:34 +0900
Subject: [PATCH 08/12] clocksource: sh_cmt: Add CMT register layout comment
In-Reply-To: <1363611758-6655-1-git-send-email-horms+renesas@verge.net.au>
References: <1363611758-6655-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363611758-6655-9-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add a comment about different register layouts
supported by the CMT driver.

Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: John Stultz <john.stultz@linaro.org>
Tested-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/clocksource/sh_cmt.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 7108963..b72b724 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -66,6 +66,21 @@ struct sh_cmt_priv {
 			    unsigned long value);
 };
 
+/* Examples of supported CMT timer register layouts and I/O access widths:
+ *
+ * "16-bit counter and 16-bit control" as found on sh7263:
+ * CMSTR 0xfffec000 16-bit
+ * CMCSR 0xfffec002 16-bit
+ * CMCNT 0xfffec004 16-bit
+ * CMCOR 0xfffec006 16-bit
+ *
+ * "32-bit counter and 16-bit control" as found on sh7372, sh73a0, r8a7740:
+ * CMSTR 0xffca0000 16-bit
+ * CMCSR 0xffca0060 16-bit
+ * CMCNT 0xffca0064 32-bit
+ * CMCOR 0xffca0068 32-bit
+ */
+
 static unsigned long sh_cmt_read16(void __iomem *base, unsigned long offs)
 {
 	return ioread16(base + (offs << 1));
-- 
1.7.10.4
