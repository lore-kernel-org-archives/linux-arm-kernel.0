From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Thu, 10 Nov 2016 15:19:05 +0000
Subject: [PATCH -next] cpufreq: brcmstb-avs-cpufreq: make symbol
 brcm_avs_cpufreq_attr static
Message-ID: <1478791145-21137-1-git-send-email-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Fixes the following sparse warning:

drivers/cpufreq/brcmstb-avs-cpufreq.c:982:18: warning:
 symbol 'brcm_avs_cpufreq_attr' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/cpufreq/brcmstb-avs-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index b761d54..4fda623 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -979,7 +979,7 @@ cpufreq_freq_attr_ro(brcm_avs_pmap);
 cpufreq_freq_attr_ro(brcm_avs_voltage);
 cpufreq_freq_attr_ro(brcm_avs_frequency);
 
-struct freq_attr *brcm_avs_cpufreq_attr[] = {
+static struct freq_attr *brcm_avs_cpufreq_attr[] = {
 	&cpufreq_freq_attr_scaling_available_freqs,
 	&brcm_avs_pstate,
 	&brcm_avs_mode,
