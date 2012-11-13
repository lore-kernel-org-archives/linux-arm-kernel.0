From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Mon, 12 Nov 2012 16:33:17 -0800 (PST)
Subject: [PATCH] sh: clkfwk: fixup unsed variable warning
In-Reply-To: <201211122243.08450.arnd@arndb.de>
References: <1352446165-19298-1-git-send-email-horms@verge.net.au>
 <1352446165-19298-6-git-send-email-horms@verge.net.au>
 <201211122243.08450.arnd@arndb.de>
Message-ID: <87625apcja.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch solves above warning

${LINUX}/drivers/sh/clk/cpg.c:404:6: warning: \
unused variable 'val' [-Wunused-variable]

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
>> Arnd, Simon

Sorry, it is my fault

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
1.7.9.5
