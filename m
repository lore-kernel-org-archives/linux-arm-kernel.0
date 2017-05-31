From: akpm@linux-foundation.org (Andrew Morton)
Date: Wed, 31 May 2017 13:54:04 -0700
Subject: [PATCH v2 3/6] kernel/reboot.c: export pm_power_off_prepare
In-Reply-To: <20170531061457.23744-4-o.rempel@pengutronix.de>
References: <20170531061457.23744-1-o.rempel@pengutronix.de>
 <20170531061457.23744-4-o.rempel@pengutronix.de>
Message-ID: <20170531135404.9110be8a08fbcf83ee9e7939@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 31 May 2017 08:14:54 +0200 Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> we need it to preconfigure PMIC to properly power off the system.

Who is "we", what is a "PMIC", what architecture is affected and where
is this code which references pm_power_off_prepare?

> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -49,6 +49,7 @@ int reboot_force;
>   */
>  
>  void (*pm_power_off_prepare)(void);
> +EXPORT_SYMBOL(pm_power_off_prepare);
>  
>  /**
>   *	emergency_restart - reboot the system
> -- 
> 2.11.0
