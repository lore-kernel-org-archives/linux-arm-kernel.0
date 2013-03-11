From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 11 Mar 2013 08:57:49 +0800
Subject: [PATCH V2] cpufreq: ARM big LITTLE: Add generic cpufreq driver
 and its DT glue
In-Reply-To: <513CAD9B.908@gmail.com>
References: <6cba8f153cfd4b0d3075a34a6dfe287bdec2eb06.1362676407.git.viresh.kumar@linaro.org>
 <513CAD9B.908@gmail.com>
Message-ID: <CAKohponV8MR=J8bbNFxGF9JXQB0uadv7iDcbW9D-qr2N53U_kQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 March 2013 23:58, Francesco Lavra <francescolavra.fl@gmail.com> wrote:
> On 03/07/2013 06:14 PM, Viresh Kumar wrote:
>> +void bL_cpufreq_unregister(struct cpufreq_arm_bL_ops *ops)
>> +{
>> +     if (arm_bL_ops != ops) {
>> +             pr_info("%s: Registered with: %s, can't unregister, exiting\n",
>> +                             __func__, arm_bL_ops->name);
>> +     }
>
> The code is not doing what the info message says.

Yes, following is the improvement:

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index 8b8b07e..9d449cf 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -264,8 +264,9 @@ EXPORT_SYMBOL_GPL(bL_cpufreq_register);
 void bL_cpufreq_unregister(struct cpufreq_arm_bL_ops *ops)
 {
        if (arm_bL_ops != ops) {
-               pr_info("%s: Registered with: %s, can't unregister, exiting\n",
+               pr_err("%s: Registered with: %s, can't unregister, exiting\n",
                                __func__, arm_bL_ops->name);
+               return;
        }
