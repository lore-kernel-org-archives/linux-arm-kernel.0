From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 08 Nov 2011 14:21:18 +0900
Subject: [PATCH] arm: exynos: Fix compiler error with THIS_MODULE
In-Reply-To: <20111107054550.GA1943@july>
References: <20111107054550.GA1943@july>
Message-ID: <04f001cc9dd6$3eb12260$bc136720$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> From: Kyungmin Park <kyungmin.park@samsung.com>
> 
>   CC      arch/arm/mach-exynos/cpuidle.o
> arch/arm/mach-exynos/cpuidle.c:36: error: 'THIS_MODULE' undeclared here
(not in
> a function)
> arch/arm/mach-exynos/cpuidle.c: In function 'exynos4_enter_idle':
> arch/arm/mach-exynos/cpuidle.c:42: error: storage size of 'before' isn't
known
> arch/arm/mach-exynos/cpuidle.c:42: error: storage size of 'after' isn't
known
> arch/arm/mach-exynos/cpuidle.c:46: error: implicit declaration of function
> 'do_gettimeofday'
> arch/arm/mach-exynos/cpuidle.c:52: error: 'USEC_PER_SEC' undeclared (first
use
> in this function)
> arch/arm/mach-exynos/cpuidle.c:52: error: (Each undeclared identifier is
reported
> only once
> arch/arm/mach-exynos/cpuidle.c:52: error: for each function it appears
in.)
> arch/arm/mach-exynos/cpuidle.c:42: warning: unused variable 'after'
> arch/arm/mach-exynos/cpuidle.c:42: warning: unused variable 'before'
> make[1]: *** [arch/arm/mach-exynos/cpuidle.o] Error 1
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> diff --git a/arch/arm/mach-exynos/cpuidle.c
b/arch/arm/mach-exynos/cpuidle.c
> index bf7e96f..84628a8 100644
> --- a/arch/arm/mach-exynos/cpuidle.c
> +++ b/arch/arm/mach-exynos/cpuidle.c
> @@ -9,6 +9,7 @@
>  */
> 
>  #include <linux/kernel.h>
> +#include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/cpuidle.h>
>  #include <linux/io.h>

Yes, that happened due to the commit 32aaeffbd4a7 (Merge branch
'modsplit-Oct31_2011'...) and I need to fix other Samsung stuff also.

OK, will apply.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
