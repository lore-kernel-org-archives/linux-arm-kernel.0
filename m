From: padma.v@samsung.com (Padmavathi Venna)
Date: Tue, 11 Oct 2011 17:15:29 +0530
Subject: [RESEND][PATCH V2 1/2] ARM: CLKDEV: Add Common Macro for clk_lookup
In-Reply-To: <1318333530-7023-1-git-send-email-padma.v@samsung.com>
References: <1318333530-7023-1-git-send-email-padma.v@samsung.com>
Message-ID: <1318333530-7023-2-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Padmavathi Venna <padma.v@samsung.com> 

Added a standardized macro CLKDEV_INIT which can used across all
the platforms to support clkdev

Suggested by: Russell King <rmk+kernel@arm.linux.org.uk>
Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
Signed-off-by: Rajeshwari Shinde <rajeshwari.s@samsung.com>
---
 include/linux/clkdev.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/include/linux/clkdev.h b/include/linux/clkdev.h
index 457bcb0..34c9918 100644
--- a/include/linux/clkdev.h
+++ b/include/linux/clkdev.h
@@ -24,6 +24,13 @@ struct clk_lookup {
 	struct clk		*clk;
 };
 
+#define CLKDEV_INIT(d, n, c)	\
+	{	\
+		.dev_id = d,	\
+		.con_id = n,	\
+		.clk = c,	\
+	}
+
 struct clk_lookup *clkdev_alloc(struct clk *clk, const char *con_id,
 	const char *dev_fmt, ...);
 
-- 
1.7.4.4
