From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 11 Dec 2015 11:11:19 +0530
Subject: [PATCH v5 3/7] ARM: dts: Exynos542x/5800: add CPU OPP properties
In-Reply-To: <566A5F0B.8040609@samsung.com>
References: <1449766729-435-4-git-send-email-b.zolnierkie@samsung.com>
 <20151211031646.GL3612@ubuntu> <566A4231.9050608@osg.samsung.com>
 <20151211033253.GN3612@ubuntu> <566A4A60.8060402@samsung.com>
 <20151211041349.GO3612@ubuntu> <566A4E82.3040203@samsung.com>
 <20151211043802.GP3612@ubuntu> <566A56DF.5040001@osg.samsung.com>
 <566A5F0B.8040609@samsung.com>
Message-ID: <20151211054119.GS3612@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11-12-15, 14:28, Krzysztof Kozlowski wrote:
> Actually I think there is no nice way of making this as separate paths.
> As Javier's mentioned, there aren't many differences. Currently the CPU
> ordering is the only difference in DT.
> 
> Making it as separate path would create hierarchy like:
>  - exynos5420-based-board.dts
>    \- include: exynos5420.dtsi
>       \- include: exynos5.dtsi
>    \- include: exynos5420-cpu.dtsi (the cpus are not in exynos5420.dtsi)
> 
>  - exynos5422-based-board.dts
>    \- include: exynos5420.dtsi
>       \- include: exynos5.dtsi
>    \- include: exynos5422-cpu.dtsi (the cpus are not in exynos5420.dtsi)
> 
> which of course is okay... except we keep the definition of CPUs
> completely outside of main Exynos5420 DTSI. Then we have to include both
> DTSI for each new DTS.

So what? There isn't anything wrong in this case and is just the right
thing to do, IMHO. We have just kept the CPU devices separately,
simple.

-- 
viresh
