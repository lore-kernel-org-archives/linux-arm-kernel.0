From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 29 Jan 2013 10:21:56 +0530
Subject: [PATCH v2] cpufreq: instantiate cpufreq-cpu0 as a platform_driver
In-Reply-To: <1359428020-21068-1-git-send-email-shawn.guo@linaro.org>
References: <1359428020-21068-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAOh2x=kCMZHxUEh0uWDmj-22_Vrk5iegO6CZswsn_NJ3GyBc0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 8:23 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> As multiplatform build is being adopted by more and more ARM platforms,
> initcall function should be used very carefully.  For example, when
> GENERIC_CPUFREQ_CPU0 is built in the kernel, cpu0_cpufreq_driver_init()
> will be called on all the platforms to initialize cpufreq-cpu0 driver.
>
> To eliminate this undesired the effect, the patch changes cpufreq-cpu0
> driver to have it instantiated as a platform_driver.  Then it will only
> run on platforms that create the platform_device "cpufreq-cpu0".
>
> Along with the change, it also changes cpu_dev to be &pdev->dev,
> so that managed functions can start working, and module build gets
> supported too.
>
> The existing users of cpufreq-cpu0 driver highbank and am33xx are also
> updated accordingly to adapt the changes.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Mark Langsdorf <mark.langsdorf@calxeda.com>
> Cc: AnilKumar Ch <anilkumar@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
