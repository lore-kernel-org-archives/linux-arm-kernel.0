From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Mar 2016 17:04:26 +0200
Subject: [PATCH V2 3/3] cpufreq: exynos: Use generic platdev driver
In-Reply-To: <81a8da75a0e7783e2b47f9e04297f167e8134afe.1459233524.git.viresh.kumar@linaro.org>
References: <cover.1459233524.git.viresh.kumar@linaro.org>
 <81a8da75a0e7783e2b47f9e04297f167e8134afe.1459233524.git.viresh.kumar@linaro.org>
Message-ID: <3810049.oQlCXiQ5bk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 March 2016 12:09:49 Viresh Kumar wrote:
> -static void __init exynos_cpufreq_init(void)
> -{
> -       struct device_node *root = of_find_node_by_path("/");
> -       const struct of_device_id *match;
> -
> -       match = of_match_node(exynos_cpufreq_matches, root);
> -       if (!match) {
> -               platform_device_register_simple("exynos-cpufreq", -1, NULL, 0);
> -               return;
> -       }
> -
> -       platform_device_register_simple(match->data, -1, NULL, 0);
> -}

How is the "exynos-cpufreq" case handled now? Is that no longer used now?
I assume the patch is correct based on Krzysztof's review, but it might be
good to explain this better.

	Arnd
