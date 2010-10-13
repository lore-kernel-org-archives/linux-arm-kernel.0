From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 13 Oct 2010 16:55:55 +0900
Subject: [PATCH v2 4/6] ARM: S5P: Add EPLL rate change warning
In-Reply-To: <1286883983-27790-1-git-send-email-sw.youn@samsung.com>
References: <1286882399-27595-1-git-send-email-sw.youn@samsung.com>
	<1286883983-27790-1-git-send-email-sw.youn@samsung.com>
Message-ID: <002301cb6aac$12a05e10$37e11a30$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Seungwhan Youn wrote:
> 
> This patch adds warning about changing EPLL rate to notice that other
> driver that controls H/W, which is using EPLL, will has unknown effects
> by this EPLL rate change.
> 
> Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
> ---
>  arch/arm/mach-s5p64x0/clock-s5p6440.c |    3 +++
>  arch/arm/mach-s5p64x0/clock-s5p6450.c |    3 +++
>  arch/arm/mach-s5pc100/clock.c         |    3 +++
>  arch/arm/mach-s5pv210/clock.c         |    3 +++
>  4 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s5p64x0/clock-s5p6440.c b/arch/arm/mach-
> s5p64x0/clock-s5p6440.c
> index 1e3f517..0b539d5 100644
> --- a/arch/arm/mach-s5p64x0/clock-s5p6440.c
> +++ b/arch/arm/mach-s5p64x0/clock-s5p6440.c
> @@ -79,6 +79,9 @@ static int s5p6440_epll_set_rate(struct clk *clk,
unsigned long
> rate)
>  	__raw_writel(epll_con, S5P_EPLL_CON);
>  	__raw_writel(epll_con_k, S5P_EPLL_CON_K);
> 
> +	printk(KERN_WARNING "EPLL Rate changes from %lu to %lu\n",
> +			clk->rate, rate);

Do we really need KERN_WARNING here?
How about just KERN_INFO?...In my opinion, to change EPLL value seems to be
nearer 'information' message more than 'warning'.

(others, same)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
