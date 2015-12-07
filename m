From: pi-cheng.chen@linaro.org (Pi-Cheng Chen)
Date: Mon, 7 Dec 2015 20:43:21 +0800
Subject: [PATCH 1/2] cpufreq: mt8173: migrate to use operating-points-v2
 bindings
In-Reply-To: <20151207100427.GG3294@ubuntu>
References: <1449305584-414-1-git-send-email-pi-cheng.chen@linaro.org>
 <1449305584-414-2-git-send-email-pi-cheng.chen@linaro.org>
 <20151207100427.GG3294@ubuntu>
Message-ID: <CALx668XK_hriOqcKSqypT61XfMx50TjxRH5n038ju8CdCsTpUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 7, 2015 at 6:04 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 05-12-15, 16:53, Pi-Cheng Chen wrote:
>> diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
>> index 257bcb9..17e9cad 100644
>> --- a/drivers/cpufreq/mt8173-cpufreq.c
>> +++ b/drivers/cpufreq/mt8173-cpufreq.c
>> @@ -344,6 +344,9 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>>       unsigned long rate;
>>       int ret;
>>
>> +     /* Mark the first owner of this CPU DVFS domain information */
>> +     cpumask_set_cpu(cpu, &info->cpus);
>> +
>
> This is bad, sorry about that. Please update
> dev_pm_opp_of_get_sharing_cpus() to update this as well.

Hi Viresh,

Thanks for reviewing.
Will do it.

Pi-Cheng

>
> --
> viresh
