From: colin.king@canonical.com (Colin King)
Date: Sun, 25 Sep 2016 14:40:13 -0700
Subject: [PATCH] cpufreq: st: add missing \n to end of dev_err message
Message-ID: <20160925214013.12430-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Trival fix, dev_err message is missing a \n, so add it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/cpufreq/sti-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/sti-cpufreq.c b/drivers/cpufreq/sti-cpufreq.c
index 0404203..b366e6d 100644
--- a/drivers/cpufreq/sti-cpufreq.c
+++ b/drivers/cpufreq/sti-cpufreq.c
@@ -163,7 +163,7 @@ static int sti_cpufreq_set_opp_info(void)
 
 	reg_fields = sti_cpufreq_match();
 	if (!reg_fields) {
-		dev_err(dev, "This SoC doesn't support voltage scaling");
+		dev_err(dev, "This SoC doesn't support voltage scaling\n");
 		return -ENODEV;
 	}
 
-- 
2.9.3
