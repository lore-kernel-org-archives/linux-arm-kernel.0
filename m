From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 08 Aug 2013 09:44:29 -0600
Subject: [PATCH 35/35] cpufreq: tegra: use
 cpufreq_table_validate_and_show()
In-Reply-To: <568f3dbd414b050bb2319d960fb5044a5aed8ee3.1375964117.git.viresh.kumar@linaro.org>
References: <cover.1375964117.git.viresh.kumar@linaro.org>
 <568f3dbd414b050bb2319d960fb5044a5aed8ee3.1375964117.git.viresh.kumar@linaro.org>
Message-ID: <5203BCDD.40809@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2013 07:48 AM, Viresh Kumar wrote:
> Lets use cpufreq_table_validate_and_show() instead of calling
> cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().

Assuming the new function simply does what the two removed lines do,
this looks fine to me.

>  static int tegra_cpu_exit(struct cpufreq_policy *policy)
>  {
> -	cpufreq_frequency_table_cpuinfo(policy, freq_table);

This doesn't seem to be mentioned in the commit description. I assume
this is simply dead/useless code removal?
