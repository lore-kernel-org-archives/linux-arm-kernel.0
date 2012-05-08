From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 08 May 2012 09:43:34 +0200
Subject: [PATCH] ARM: EXYNOS: Add platform resource definitions for
 FIMC-LITE
In-Reply-To: <4FA8CCC9.9030601@samsung.com>
References: <1336148260-19952-1-git-send-email-s.nawrocki@samsung.com>
 <017b01cd2cdd$4e4ff570$eaefe050$%kim@samsung.com>
 <4FA8CCC9.9030601@samsung.com>
Message-ID: <4FA8CEA6.3000008@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08/2012 09:35 AM, Sylwester Nawrocki wrote:
> On 05/08/2012 07:42 AM, Kukjin Kim wrote:
>> Sylwester Nawrocki wrote:
>>>
>>> Add the gate clocks and register region address definition for
>>> FIMC-LITE devices available in Exynos4x12 and Exynos5 SoCs.
>>>
>> This is right description? I can't find your changes for EXYNOS4412 and
>> EXYNOS5 here. Only this is for EXYNOS4212 SoC.
> 
> Sorry, I wasn't precise enough. EXYNOS4_PA_FIMC_LITE is for EXYNOS4212
> and EXYNOS4412 though. Please note it is initially needed for DT platforms,
> until we get proper clock DT bindings for EXYNOS. Is there, BTW, anyone 
> known to work on converting EXYNOS to the common clock framework ?
> 
> This patch was intended for EXYNOS4212/4412. AFAICS clock code in
> mach-exynos/clock-exynos4412.c is a subset of the EXYNOS4412 platform:
              ^^^^^^^^^^^^^^^^^^
Uh, should be clock-exynos4212.c.

> static void __init exynos4_init_clocks(int xtal)
> {
> 	...
> 	if (soc_is_exynos4210())
> 		exynos4210_register_clocks();
> 	else if (soc_is_exynos4212() || soc_is_exynos4412())
> 		exynos4212_register_clocks();
> 	
> 	exynos4_register_clocks();
> 	...
> }
> 
> Should I resend the patch or could you remove " and Exynos5 SoCs"
> from the description ?
> 
> --
> 
> Regards,
> Sylwester Nawrocki
