From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 19 Feb 2014 13:45:45 +0100
Subject: [PATCH 1/1] ARM: Exynos: Add generic compatible string
In-Reply-To: <1392809645-631-1-git-send-email-sachin.kamat@linaro.org>
References: <1392809645-631-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <5304A779.1060702@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sachin,

[adding linux-arm-kernel ML to CC list]

On 19.02.2014 12:34, Sachin Kamat wrote:
> To avoid modifying the kernel every time a new SoC variant
> comes out.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>   arch/arm/mach-exynos/mach-exynos4-dt.c |    1 +
>   arch/arm/mach-exynos/mach-exynos5-dt.c |    1 +
>   2 files changed, 2 insertions(+)
>
> diff --git a/arch/arm/mach-exynos/mach-exynos4-dt.c b/arch/arm/mach-exynos/mach-exynos4-dt.c
> index d3e54b7644d7..5d037b561253 100644
> --- a/arch/arm/mach-exynos/mach-exynos4-dt.c
> +++ b/arch/arm/mach-exynos/mach-exynos4-dt.c
> @@ -28,6 +28,7 @@ static void __init exynos4_dt_machine_init(void)
>   }
>
>   static char const *exynos4_dt_compat[] __initdata = {
> +	"samsung,exynos4",
>   	"samsung,exynos4210",
>   	"samsung,exynos4212",
>   	"samsung,exynos4412",
> diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
> index 37ea261f0f6c..ad0db5a93da8 100644
> --- a/arch/arm/mach-exynos/mach-exynos5-dt.c
> +++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
> @@ -50,6 +50,7 @@ static void __init exynos5_dt_machine_init(void)
>   }
>
>   static char const *exynos5_dt_compat[] __initdata = {
> +	"samsung,exynos5",
>   	"samsung,exynos5250",
>   	"samsung,exynos5420",
>   	"samsung,exynos5440",
>

Since all Exynos chips can be easily recognized using dedicated chip ID 
register, I wonder whether we really need to maintain two distinct board 
files for Exynos 4 and 5 series, especially when both of them are doing 
mostly the same set up, which can be simply generalized to cover all the 
cases.

Instead of adding just another level of artificially fine grained 
compatible strings, I'd rather suggest merging both board files together 
and adding a single compatible string identifying all SoCs that can be 
further differentiated by using hardware chip ID register.

What do you think?

P.S. Please always keep respective subsystem/arch level MLs on CC list, 
in this case linux-arm-kernel. The linux-samsung-soc ML is just a 
convenience tool to group all threads about Samsung SoCs, not a way to 
bypass respective subsystem MLs.

Best regards,
Tomasz
