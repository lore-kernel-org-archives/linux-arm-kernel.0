From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 08 Aug 2012 19:47:26 +0900
Subject: [PATCH 2/9] ARM: plat-s3c24xx: Don't use FIQ_START
In-Reply-To: <1344207819-3415-2-git-send-email-anton.vorontsov@linaro.org>
References: <20120805230238.GA1663@lizard>
 <1344207819-3415-2-git-send-email-anton.vorontsov@linaro.org>
Message-ID: <0af201cd7553$3346dd70$99d49850$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Anton Vorontsov wrote:
> 
> We're about to remove FIQ_START mess, so move the platform-specific
> detail inside platform-specific s3c24xx_set_fiq().
> 
> Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

BTW, how was going on the 'change FIQ_START to a variable' patch from Shawn
Guo?
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-June/106486.html

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.


> ---
>  arch/arm/plat-s3c24xx/irq.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/plat-s3c24xx/irq.c b/arch/arm/plat-s3c24xx/irq.c
> index fe57bbb..e4e9567 100644
> --- a/arch/arm/plat-s3c24xx/irq.c
> +++ b/arch/arm/plat-s3c24xx/irq.c
> @@ -503,7 +503,7 @@ int s3c24xx_set_fiq(unsigned int irq, bool on)
>  	unsigned offs;
> 
>  	if (on) {
> -		offs = irq - FIQ_START;
> +		offs = irq - IRQ_EINT0;
>  		if (offs > 31)
>  			return -EINVAL;
> 
> --
> 1.7.10.4
