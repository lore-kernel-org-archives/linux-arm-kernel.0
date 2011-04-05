From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 05 Apr 2011 19:09:56 +0530
Subject: [PATCH 1/4] OMAP2+: clockdomain: Add an api to read idle mode
In-Reply-To: <1302007497-10525-2-git-send-email-rnayak@ti.com>
References: <1302007497-10525-1-git-send-email-rnayak@ti.com>
	<1302007497-10525-2-git-send-email-rnayak@ti.com>
Message-ID: <4D9B1BAC.3090700@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/5/2011 6:14 PM, Rajendra Nayak wrote:
> Add a clockdomain api to check if hardware supervised
> idle transitions are enabled on a clockdomain.
>
> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
> ---
>   arch/arm/mach-omap2/clockdomain.c |   21 +++++++++++++++++++++
>   arch/arm/mach-omap2/clockdomain.h |    3 +++
>   2 files changed, 24 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
> index ab87854..1de6def 100644
> --- a/arch/arm/mach-omap2/clockdomain.c
> +++ b/arch/arm/mach-omap2/clockdomain.c
> @@ -795,6 +795,27 @@ void clkdm_deny_idle(struct clockdomain *clkdm)
>   	arch_clkdm->clkdm_deny_idle(clkdm);
>   }
>
> +/**
> + * clkdm_is_idle - Check if the clkdm hwsup/autoidle is enabled
> + * @clkdm: struct clockdomain *
> + *
> + * Returns true if the clockdomain is in hardware-supervised
> + * idle mode, or 0 otherwise.
> + *
> + */
> +int clkdm_is_idle(struct clockdomain *clkdm)
 >
Name of the API not seems to fit correctly.
Shoule it be something like "clkdm_is_in_hwsup"?
