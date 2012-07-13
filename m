From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 13 Jul 2012 15:40:14 +0200
Subject: [PATCH 04/11] misc/atmel_tc: make atmel_tc.tcb_config member
 point to const data
In-Reply-To: <1342182734-321-6-git-send-email-y>
References: <1342182734-321-1-git-send-email-y>
 <1342182734-321-6-git-send-email-y>
Message-ID: <5000253E.7050006@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/13/2012 02:32 PM, y at pengutronix.de :
> From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> 
> This prepares of_device_id.data becoming const. Without this change
> the following warning would occur:
> 
> 	drivers/misc/atmel_tclib.c: In function 'tc_probe':
> 	drivers/misc/atmel_tclib.c:170: warning: assignment discards qualifiers from pointer target type
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks Uwe!

> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> Hello,
> 
> btw, get_maintainer.pl suggested to Cc:
> linux-atm-general at lists.sourceforge.net but not the Atmel people because
> include/linux/atmel_tc.h matches include/linux/atm*.

Ah, ok, good to know. I will try to update MAINTAINERS file for this.

Bye,

> Best regards
> Uwe
>  include/linux/atmel_tc.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/atmel_tc.h b/include/linux/atmel_tc.h
> index 1d14b1dc..89a931b 100644
> --- a/include/linux/atmel_tc.h
> +++ b/include/linux/atmel_tc.h
> @@ -63,7 +63,7 @@ struct atmel_tc {
>  	struct platform_device	*pdev;
>  	struct resource		*iomem;
>  	void __iomem		*regs;
> -	struct atmel_tcb_config	*tcb_config;
> +	const struct atmel_tcb_config *tcb_config;
>  	int			irq[3];
>  	struct clk		*clk[3];
>  	struct list_head	node;
> 


-- 
Nicolas Ferre
