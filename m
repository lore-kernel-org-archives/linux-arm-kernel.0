From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 7 Oct 2010 20:00:31 +0200
Subject: [PATCH v2] ARM: allow, but warn, when issuing ioremap() on RAM
In-Reply-To: <1286454549-19690-1-git-send-email-felipe.contreras@gmail.com>
References: <20101007115156.GE27250@jasper.tkos.co.il>
	<1286454549-19690-1-git-send-email-felipe.contreras@gmail.com>
Message-ID: <20101007180031.GT29673@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Oct 07, 2010 at 03:29:09PM +0300, Felipe Contreras wrote:
> Many drivers are broken, and there's no alternative in sight. Such a big
> change should stay as a warning for now, and only later should it
> actually fail.
> 
> The drivers are not doing something correct, we get it, but for now it's
> better to allow them to work (they do 99% of the time anyway) rather
> than to force everyone to revert this patch in their internal trees
> until there's a solution. A slightly broken functionality is better than
> no functionality at all.
> 
> A warning lets people know that what they are doing is not right, and
> they should fix it.
> 
> Cc: Han Jonghun <jonghun79.han@gmail.com>
> Cc: Hemant Pedanekar <hemantp@ti.com>
> Cc: Arnd Hannemann <arnd@arndnet.de>
> Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Cc: Omar Ramirez Luna <omar.ramirez@ti.com>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  arch/arm/mm/ioremap.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> 
> For issues related to this:
> http://article.gmane.org/gmane.linux.ports.arm.kernel/84454
> http://article.gmane.org/gmane.linux.ports.sh.devel/8560
> http://www.spinics.net/lists/linux-fbdev/msg01745.html
> http://article.gmane.org/gmane.linux.drivers.video-input-infrastructure/22271
> 
> diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
> index ab50627..a168673 100644
> --- a/arch/arm/mm/ioremap.c
> +++ b/arch/arm/mm/ioremap.c
> @@ -202,10 +202,9 @@ void __iomem * __arm_ioremap_pfn_caller(unsigned long pfn,
>  		return NULL;
>  
>  	/*
> -	 * Don't allow RAM to be mapped - this causes problems with ARMv6+
> +	 * This causes problems with ARMv6+. Will be disallowed soon.
maybe specify soon as "before 2.6.37"?

Other than that, Acked-by: Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de>
because there is no other solution to make it into the kernel before
.36.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
