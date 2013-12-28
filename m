From: mat.krawczuk@gmail.com (Mateusz Krawczuk)
Date: Sat, 28 Dec 2013 18:09:15 +0100
Subject: [PATCH v5 Resend 2/3] Cpufreq: s5pv210 cpufreq fixes for CCF
In-Reply-To: <1388250556-4594-1-git-send-email-mat.krawczuk@gmail.com>
References: <1388250556-4594-1-git-send-email-mat.krawczuk@gmail.com>
Message-ID: <1388250556-4594-3-git-send-email-mat.krawczuk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mateusz Krawczuk <m.krawczuk@partner.samsung.com>

Use common clock framework api to get clock.

Signed-off-by: Mateusz Krawczuk <m.krawczuk@partner.samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/cpufreq/s5pv210-cpufreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index e3973da..ab0365a 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -471,17 +471,17 @@ static int __init s5pv210_cpu_init(struct cpufreq_policy *policy)
 	unsigned long mem_type;
 	int ret;
 
-	cpu_clk = clk_get(NULL, "armclk");
+	cpu_clk = clk_get_sys("s5pv210-cpufreq", "armclk");
 	if (IS_ERR(cpu_clk))
 		return PTR_ERR(cpu_clk);
 
-	dmc0_clk = clk_get(NULL, "sclk_dmc0");
+	dmc0_clk = clk_get_sys("s5pv210-cpufreq", "sclk_dmc0");
 	if (IS_ERR(dmc0_clk)) {
 		ret = PTR_ERR(dmc0_clk);
 		goto out_dmc0;
 	}
 
-	dmc1_clk = clk_get(NULL, "hclk_msys");
+	dmc1_clk = clk_get_sys("s5pv210-cpufreq", "hclk_msys");
 	if (IS_ERR(dmc1_clk)) {
 		ret = PTR_ERR(dmc1_clk);
 		goto out_dmc1;
-- 
1.8.3.3
