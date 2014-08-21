From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 21 Aug 2014 10:39:41 +0530
Subject: [PATCH v4 13/16] cpufreq: Add cpufreq driver for Tegra124
In-Reply-To: <1408568684-11016-14-git-send-email-ttynkkynen@nvidia.com>
References: <1408568684-11016-1-git-send-email-ttynkkynen@nvidia.com>
 <1408568684-11016-14-git-send-email-ttynkkynen@nvidia.com>
Message-ID: <CAKohpo=rwM7Gju83heSzhw02J+FP1Jv2zdABZGsXFTF8KH=oEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 August 2014 02:34, Tuomas Tynkkynen <ttynkkynen@nvidia.com> wrote:
> Add a new cpufreq driver for Tegra124. Instead of using the PLLX as
> the CPU clocksource, switch immediately to the DFLL. It allows the use
> of higher clock rates, and will automatically scale the CPU voltage as
> well. Besides the CPU clocksource switch, we let the cpufreq-cpu0 driver
> for all the cpufreq operations.
>
> This driver also relies on the DFLL driver to fill the OPP table for the
> CPU0 device, so that the cpufreq-cpu0 driver knows what frequencies to
> use.
>
> Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
> ---
> v4:
>  - check for get_cpu_device() return value
>  - add comment why an extra platform driver+device is required
>  - back to 'depends on GENERIC_CPUFREQ_CPU0'

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
