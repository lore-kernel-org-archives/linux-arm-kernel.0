From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 28 Mar 2013 18:12:31 +0530
Subject: [PATCH V5 1/4] cpufreq: exynos: Add cpufreq driver for exynos5440
In-Reply-To: <1364457923-8499-2-git-send-email-amit.daniel@samsung.com>
References: <1364457923-8499-1-git-send-email-amit.daniel@samsung.com>
 <1364457923-8499-2-git-send-email-amit.daniel@samsung.com>
Message-ID: <CAKohpon5BYW0Ypx8SbBsSUuugUnmYU=rBCMizz-CxuHjCzObpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 March 2013 13:35, Amit Daniel Kachhap <amit.daniel@samsung.com> wrote:
> +++ b/drivers/cpufreq/exynos5440-cpufreq.c
> +static int exynos_cpufreq_cpu_init(struct cpufreq_policy *policy)
> +{
> +       policy->cur = dvfs_info->cur_frequency;
> +       cpufreq_frequency_table_get_attr(dvfs_info->freq_table, policy->cpu);
> +
> +       /* set the transition latency value */
> +       policy->cpuinfo.transition_latency = dvfs_info->latency;
> +
> +       cpumask_setall(policy->cpus);
> +
> +       return cpufreq_frequency_table_cpuinfo(policy, dvfs_info->freq_table);

I missed this earlier and saw this mistake in yet another driver.
You need to call cpufreq_frequency_table_get_attr() only when
cpufreq_frequency_table_cpuinfo() has passed.

> +}
