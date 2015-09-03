From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 3 Sep 2015 21:20:29 +0530
Subject: [PATCH] cpufreq: Add ARM_MT8173_CPUFREQ dependencyon THERMAL
In-Reply-To: <1441293658-18199-1-git-send-email-linux@roeck-us.net>
References: <1441293658-18199-1-git-send-email-linux@roeck-us.net>
Message-ID: <20150903155029.GB5332@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03-09-15, 08:20, Guenter Roeck wrote:
> If ARM_MT8173_CPUFREQ is configured, and THERMAL is configured as module,
> the following build error is seen for arm:allmodconfig and
> arm64:allmodconfig.
> 
> drivers/built-in.o: In function `mtk_cpufreq_ready':
> :(.text+0x32a20c): undefined reference to `of_cpufreq_cooling_register'
> drivers/built-in.o: In function `mtk_cpufreq_exit':
> :(.text+0x32a420): undefined reference to `cpufreq_cooling_unregister'
> 
> The fix is similar to CPUFREQ_DT, but more restrictive since
> ARM_MT8173_CPUFREQ can not be built as module.
> 
> Fixes: 1453863fb02a ("cpufreq: mediatek: Add MT8173 cpufreq driver")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> It might also make sense to declare ARM_MT8173_CPUFREQ as tristate
> and relax the conditions, but I don't know if that is feasible.
> 
>  drivers/cpufreq/Kconfig.arm | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
