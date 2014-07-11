From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 11 Jul 2014 10:05:56 +0530
Subject: [PATCH 12/13] cpufreq: Add cpufreq driver for Tegra124
In-Reply-To: <1405028569-14253-13-git-send-email-ttynkkynen@nvidia.com>
References: <1405028569-14253-1-git-send-email-ttynkkynen@nvidia.com>
 <1405028569-14253-13-git-send-email-ttynkkynen@nvidia.com>
Message-ID: <CAKohpom9ORXFiUU4=V+CxgN0ZOFLMEhEjHiU8HsYUYDybNXgHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tuomas,

On 11 July 2014 03:12, Tuomas Tynkkynen <ttynkkynen@nvidia.com> wrote:
> Add a new cpufreq driver for Tegra124. Instead of using the PLLX as
> the CPU clocksource, switch immediately to the DFLL. It allows the use
> of higher clock rates, and will automatically scale the CPU voltage as
> well. We also rely on the DFLL driver to determine the CPU clock
> frequencies that the chip supports, so that we can directly build a
> cpufreq table with the OPP library helper dev_pm_opp_init_cpufreq_table.
>
> This driver is a completely independent of the old cpufreq driver
> (tegra-cpufreq), which is only used on Tegra20.
>
> Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>

Please reuse cpufreq-cpu0 instead of adding a new driver. Similar
is being adopted by all platforms now: krait, mvebu, etc..
