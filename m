From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 27 Feb 2014 11:09:45 +0530
Subject: [PATCH 3/3] cpufreq: stats: Refactor common code into
 __cpufreq_stats_create_table()
In-Reply-To: <1393445858-7062-3-git-send-email-skannan@codeaurora.org>
References: <1393445858-7062-3-git-send-email-skannan@codeaurora.org>
Message-ID: <CAKohpo=Xf+5OxjAuYkh_jCJ92MPuutgpHXL8fxOLq_3B18cSEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 February 2014 01:47, Saravana Kannan <skannan@codeaurora.org> wrote:
> cpufreq_frequency_get_table() is called from all callers of
> __cpufreq_stats_create_table(). So, move it inside.
>
> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> ---
>  drivers/cpufreq/cpufreq_stats.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index c52b440..9d9e366 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -180,13 +180,18 @@ static void cpufreq_stats_free_table(unsigned int cpu)
>         cpufreq_cpu_put(policy);
>  }
>
> -static int __cpufreq_stats_create_table(struct cpufreq_policy *policy,
> -               struct cpufreq_frequency_table *table)
> +static int __cpufreq_stats_create_table(struct cpufreq_policy *policy)
>  {
>         unsigned int i, j, count = 0, ret = 0;
>         struct cpufreq_stats *stat;
>         unsigned int alloc_size;
>         unsigned int cpu = policy->cpu;
> +       struct cpufreq_frequency_table *table;
> +
> +       table = cpufreq_frequency_get_table(policy->cpu);

s/policy->cpu/cpu

Otherwise, Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
