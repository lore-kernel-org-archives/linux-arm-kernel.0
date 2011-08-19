From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 19 Aug 2011 22:07:49 +0900
Subject: [PATCH] ARM: S5P: fix bug in spdif_clk_get_rate
In-Reply-To: <1313753215-29173-1-git-send-email-ch.naveen@samsung.com>
References: <1313753215-29173-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <002c01cc5e70$fef41960$fcdc4c20$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Naveen Krishna Chatradhi wrote:
> 
> Should be passing the parent clk object when
> calling for parent rate.
> 
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> ---
>  arch/arm/plat-s5p/clock.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-s5p/clock.c b/arch/arm/plat-s5p/clock.c
> index 02af235..5f84a3f 100644
> --- a/arch/arm/plat-s5p/clock.c
> +++ b/arch/arm/plat-s5p/clock.c
> @@ -192,7 +192,7 @@ unsigned long s5p_spdif_get_rate(struct clk *clk)
>  	if (IS_ERR(pclk))
>  		return -EINVAL;
> 
> -	rate = pclk->ops->get_rate(clk);
> +	rate = pclk->ops->get_rate(pclk);
>  	clk_put(pclk);
> 
>  	return rate;
> --
> 1.7.2.3

Yes, applied.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
