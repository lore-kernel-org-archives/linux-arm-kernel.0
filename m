From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 27 Jan 2012 17:15:49 +0900
Subject: [PATCH] ARM: EXYNOS: Fix
 "warning: initialization from incompatible pointer type"
In-Reply-To: <1325984332-32146-1-git-send-email-jhbird.choi@samsung.com>
References: <1325984332-32146-1-git-send-email-jhbird.choi@samsung.com>
Message-ID: <01b301ccdccb$e0caca40$a2605ec0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

jhbird.choi at samsung.com wrote:
> 
> From: Jonghwan Choi <jhbird.choi@samsung.com>
> 
> Fix the wrong function prototype.
> 
> Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>
> ---
>  arch/arm/mach-exynos/pm.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
> index c4f792d..db33f47 100644
> --- a/arch/arm/mach-exynos/pm.c
> +++ b/arch/arm/mach-exynos/pm.c
> @@ -205,7 +205,7 @@ static void exynos4_pm_prepare(void)
> 
>  }
> 
> -static int exynos4_pm_add(struct device *dev)
> +static int exynos4_pm_add(struct device *dev, struct subsys_interface *sif)
>  {
>  	pm_cpu_prep = exynos4_pm_prepare;
>  	pm_cpu_sleep = exynos4_cpu_suspend;
> --
> 1.7.1

Applied.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
