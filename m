From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 30 Mar 2016 08:46:36 +0900
Subject: [PATCH V2 3/3] cpufreq: exynos: Use generic platdev driver
In-Reply-To: <CAKohpomQ9=YK79o0fqHqZ7xexHv5EMJSPx+4KrT0RxeMh+hwWg@mail.gmail.com>
References: <cover.1459233524.git.viresh.kumar@linaro.org>
 <81a8da75a0e7783e2b47f9e04297f167e8134afe.1459233524.git.viresh.kumar@linaro.org>
 <3810049.oQlCXiQ5bk@wuerfel>
 <CAKohpomQ9=YK79o0fqHqZ7xexHv5EMJSPx+4KrT0RxeMh+hwWg@mail.gmail.com>
Message-ID: <56FB13DC.2090902@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.03.2016 00:22, Viresh Kumar wrote:
> On 29 March 2016 at 20:34, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Tuesday 29 March 2016 12:09:49 Viresh Kumar wrote:
>>> -static void __init exynos_cpufreq_init(void)
>>> -{
>>> -       struct device_node *root = of_find_node_by_path("/");
>>> -       const struct of_device_id *match;
>>> -
>>> -       match = of_match_node(exynos_cpufreq_matches, root);
>>> -       if (!match) {
>>> -               platform_device_register_simple("exynos-cpufreq", -1, NULL, 0);
>>> -               return;
>>> -       }
>>> -
>>> -       platform_device_register_simple(match->data, -1, NULL, 0);
>>> -}
>>
>> How is the "exynos-cpufreq" case handled now? Is that no longer used now?
>> I assume the patch is correct based on Krzysztof's review, but it might be
>> good to explain this better.
> 
> That's stale code, the driver got removed some time back.

Yeah, that's old driver, no longer existing. It makes sense to split the
patch - first remove the stale exynos-cpufreq and then move cpufreq-dt.
This would help avoid confusion when grepping through the history.

Best regards,
Krzysztof
