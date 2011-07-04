From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 04 Jul 2011 19:11:57 +0900
Subject: [PATCH] arm: exynos4: address a section mismatch w/ suspend issue.
In-Reply-To: <1306384822-17651-1-git-send-email-myungjoo.ham@samsung.com>
References: <1306384822-17651-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <005701cc3a32$d1c02c70$75408550$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MyungJoo Ham wrote:
> 
> The section mismatch in headsmp.S made hotplug stop working after the
> first instance of suspend-to-RAM and its wakeup.
> 
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-exynos4/headsmp.S |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos4/headsmp.S b/arch/arm/mach-
> exynos4/headsmp.S
> index 6c6cfc5..3cdeb36 100644
> --- a/arch/arm/mach-exynos4/headsmp.S
> +++ b/arch/arm/mach-exynos4/headsmp.S
> @@ -13,7 +13,7 @@
>  #include <linux/linkage.h>
>  #include <linux/init.h>
> 
> -	__INIT
> +	__CPUINIT
> 
>  /*
>   * exynos4 specific entry point for secondary CPUs.  This provides
> --
> 1.7.4.1

Will apply this into -fix tree.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
