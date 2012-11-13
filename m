From: horms@verge.net.au (Simon Horman)
Date: Tue, 13 Nov 2012 12:10:12 +0900
Subject: [PATCH 4/4] sh: clkfwk: fixup unsed variable warning
In-Reply-To: <1352776212-3211-1-git-send-email-horms@verge.net.au>
References: <1352776212-3211-1-git-send-email-horms@verge.net.au>
Message-ID: <1352776212-3211-5-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch solves above warning

${LINUX}/drivers/sh/clk/cpg.c:404:6: warning: \
unused variable 'val' [-Wunused-variable]

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 drivers/sh/clk/cpg.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/sh/clk/cpg.c b/drivers/sh/clk/cpg.c
index b3dc441..5aedcdf 100644
--- a/drivers/sh/clk/cpg.c
+++ b/drivers/sh/clk/cpg.c
@@ -401,7 +401,6 @@ static int fsidiv_enable(struct clk *clk)
 
 static int fsidiv_set_rate(struct clk *clk, unsigned long rate)
 {
-	u32 val;
 	int idx;
 
 	idx = (clk->parent->rate / rate) & 0xffff;
-- 
1.7.10.4
