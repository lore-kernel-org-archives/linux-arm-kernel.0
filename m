From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 24 Apr 2014 12:13:23 +0200
Subject: [PATCH/RFC 4/4] clk: shmobile: mstp: Set CLK_RUNTIME_PM flag
In-Reply-To: <1398334403-26181-1-git-send-email-geert+renesas@glider.be>
References: <1398334403-26181-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1398334403-26181-5-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Renesas MSTP (Module Stop) clocks are suitable for Runtime PM.

Hence set the CLK_RUNTIME_PM flag, to make of_clk enable automatic Runtime
PM management for DT devices that are tied to an MSTP clock.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/shmobile/clk-mstp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/shmobile/clk-mstp.c b/drivers/clk/shmobile/clk-mstp.c
index 2e3c08fff173..6f860bad551e 100644
--- a/drivers/clk/shmobile/clk-mstp.c
+++ b/drivers/clk/shmobile/clk-mstp.c
@@ -139,7 +139,7 @@ cpg_mstp_clock_register(const char *name, const char *parent_name,
 
 	init.name = name;
 	init.ops = &cpg_mstp_clock_ops;
-	init.flags = CLK_IS_BASIC | CLK_SET_RATE_PARENT;
+	init.flags = CLK_IS_BASIC | CLK_SET_RATE_PARENT | CLK_RUNTIME_PM;
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
 
-- 
1.7.9.5
