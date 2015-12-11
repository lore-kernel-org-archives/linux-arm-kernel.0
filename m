From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 11 Dec 2015 09:02:53 +0530
Subject: [PATCH v5 3/7] ARM: dts: Exynos542x/5800: add CPU OPP properties
In-Reply-To: <566A4231.9050608@osg.samsung.com>
References: <1449766729-435-1-git-send-email-b.zolnierkie@samsung.com>
 <1449766729-435-4-git-send-email-b.zolnierkie@samsung.com>
 <20151211031646.GL3612@ubuntu> <566A4231.9050608@osg.samsung.com>
Message-ID: <20151211033253.GN3612@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11-12-15, 00:25, Javier Martinez Canillas wrote:
> The problem is that the big and LITTLE cores have different ordering per SoCs:
> 
> - Exynos5420 and Exynos5800: cpu0-3 (Cortex-A15) and cpu4-7 (Coretx-A7)
> - Exynos5422: cpu0-3 (Cortex-A7) and cpu4-7 (Cortex-A15)
> 
> So the OPP tables are set in this DTSI file, to prevent the OPP tables
> in the Exynos5422 to be inverted for the cluster 0 and 1.

Oh dude, that's really *ugly*. :)

Reusing files/definitions is fine to the point where things are
readable. But you have screwed it up so very badly.

Over that, why can't you keep cpu0-3 as A7 and 4-7 as a15 for all the
cases? The only worrying thing for you should be that CPU0 within the
kenrel should be controllable, right? i.e. you want a A15 to boot 5800
and A7 to boot 5422.

If yes, than you could have kept the CPUs in 5422 as:
0-3: A7
4-7: A15

and in 5420 as:
4-7: A15
0-3: A7

Wouldnt' that work ?

-- 
viresh
