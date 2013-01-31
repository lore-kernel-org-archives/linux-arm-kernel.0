From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 31 Jan 2013 09:50:37 +0530
Subject: [PATCH] cpufreq: exynos: Broadcast frequency change notifications
 for all cores
In-Reply-To: <1887364.fvxYYNb7Mm@amdc1227>
References: <1887364.fvxYYNb7Mm@amdc1227>
Message-ID: <CAOh2x==GeK4qM=kjy-tzhbEh4L9AmRXoG_0tUzov1SK+uRFxcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2012 at 2:56 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> On Exynos SoCs all cores share the same frequency setting, so changing
> frequency of one core will affect rest of cores.
>
> This patch modifies the exynos-cpufreq driver to inform cpufreq core
> about this behavior and broadcast frequency change notifications for all
> cores.

>         /* When the new frequency is lower than current frequency */
>         if ((freqs.new < freqs.old) ||
> @@ -235,6 +237,7 @@ static int exynos_cpufreq_cpu_init(struct cpufreq_policy *policy)
>                 cpumask_copy(policy->related_cpus, cpu_possible_mask);
>                 cpumask_copy(policy->cpus, cpu_online_mask);
>         } else {
> +               policy->shared_type = CPUFREQ_SHARED_TYPE_ANY;
>                 cpumask_setall(policy->cpus);

I couldn't understand the use of this change. Can you please explain ?
