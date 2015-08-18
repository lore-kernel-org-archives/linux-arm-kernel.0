From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 18 Aug 2015 15:54:28 +0530
Subject: [RESEND PATCH 2/3 v6] cpufreq: mediatek: Add MT8173 cpufreq driver
In-Reply-To: <18468574.WHJNqYO5N4@amdc1976>
References: <1439803465-19683-1-git-send-email-pi-cheng.chen@linaro.org>
 <1439803465-19683-3-git-send-email-pi-cheng.chen@linaro.org>
 <18468574.WHJNqYO5N4@amdc1976>
Message-ID: <20150818102428.GD31148@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18-08-15, 12:09, Bartlomiej Zolnierkiewicz wrote:
> > +	pdev = platform_device_register_simple("mt8173-cpufreq", -1, NULL, 0);
> 
> This is not very friendly for multiplatform support
> (mt8173_cpufreq_driver_init() can be called on other platforms,
> i.e. Samsung Exynos7 one if ARCH_EXYNOS7 is also enabled in
> the kernel config).
> 
> Why can't it be fixed with checking Device Tree with
> of_machine_is_compatible("mediatek,mt8173")
> (assuming that it can be used on arm64 like on arm32)?

Because I asked him to remove that in v5 :( as I somehow had in mind
that this wouldn't even compile for other platforms.

@Pi-cheng: Please send v7 only for this patch and add the DT platform
check you were doing earlier. Sorry.

-- 
viresh
