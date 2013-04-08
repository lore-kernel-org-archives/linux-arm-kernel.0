From: amit.daniel@samsung.com (amit daniel kachhap)
Date: Mon, 8 Apr 2013 13:55:10 +0530
Subject: [PATCH V5 1/4] cpufreq: exynos: Add cpufreq driver for exynos5440
In-Reply-To: <CAKohpon5BYW0Ypx8SbBsSUuugUnmYU=rBCMizz-CxuHjCzObpQ@mail.gmail.com>
References: <1364457923-8499-1-git-send-email-amit.daniel@samsung.com>
 <1364457923-8499-2-git-send-email-amit.daniel@samsung.com>
 <CAKohpon5BYW0Ypx8SbBsSUuugUnmYU=rBCMizz-CxuHjCzObpQ@mail.gmail.com>
Message-ID: <CADGdYn7PCAPPuAe6Y+VTGq=98i0_6YvDdJsRiLcwMyfsoohbag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 28, 2013 at 6:12 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 28 March 2013 13:35, Amit Daniel Kachhap <amit.daniel@samsung.com> wrote:
> > +++ b/drivers/cpufreq/exynos5440-cpufreq.c
> > +static int exynos_cpufreq_cpu_init(struct cpufreq_policy *policy)
> > +{
> > +       policy->cur = dvfs_info->cur_frequency;
> > +       cpufreq_frequency_table_get_attr(dvfs_info->freq_table, policy->cpu);
> > +
> > +       /* set the transition latency value */
> > +       policy->cpuinfo.transition_latency = dvfs_info->latency;
> > +
> > +       cpumask_setall(policy->cpus);
> > +
> > +       return cpufreq_frequency_table_cpuinfo(policy, dvfs_info->freq_table);
>
> I missed this earlier and saw this mistake in yet another driver.
> You need to call cpufreq_frequency_table_get_attr() only when
> cpufreq_frequency_table_cpuinfo() has passed.

ok. Submitted the V6 version with this change.

>
>
> > +}
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
