From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 28 Nov 2018 14:12:50 -0800
Subject: [PATCH] clk: nomadik: Change to use DEFINE_SHOW_ATTRIBUTE macro
In-Reply-To: <154344291239.88331.14159206270303255502@swboyd.mtv.corp.google.com>
References: <20181123150600.27445-1-tiny.windzz@gmail.com>
 <154344291239.88331.14159206270303255502@swboyd.mtv.corp.google.com>
Message-ID: <154344317086.88331.8296424241716107824@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Boyd (2018-11-28 14:08:32)
> Quoting Yangtao Li (2018-11-23 07:06:00)
> > Use macro to simplify the code.
> > 
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> 
> Applied to clk-next
> 

Except this doesn't compile. I fixed it, but please actually compile
your patches before sending next time.

diff --git a/drivers/clk/clk-nomadik.c b/drivers/clk/clk-nomadik.c
index e331634d34df..a95aa96f4a68 100644
--- a/drivers/clk/clk-nomadik.c
+++ b/drivers/clk/clk-nomadik.c
@@ -455,7 +455,7 @@ static const char * const src_clk_names[] = {
 	"RNGCCLK   ",
 };
 
-static int nomadik_src_clk_show(struct seq_file *s, void *what)
+static int nomadik_src_clk_debugfs_show(struct seq_file *s, void *what)
 {
 	int i;
 	u32 src_pcksr0 = readl(src_base + SRC_PCKSR0);
