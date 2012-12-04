From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 4 Dec 2012 14:12:12 +0000
Subject: [PATCH] ARM: bcm281xx: Add timer driver
In-Reply-To: <1354593324-21300-1-git-send-email-csd@broadcom.com>
References: <1354593324-21300-1-git-send-email-csd@broadcom.com>
Message-ID: <201212041412.12383.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 04 December 2012, Christian Daudt wrote:
> This adds support for the Broadcom timer, used in the following SoCs:
> BCM11130, BCM11140, BCM11351, BCM28145, BCM28155
> 
> This patch needs the arm-soc/soc/next branch
> 
> Signed-off-by: Christian Daudt <csd@broadcom.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
>  
> -static void timer_init(void)
> -{
> -}
> +extern void bcm_timer_init(void);
>  
>  static struct sys_timer timer = {
> -	.init = timer_init,
> +	.init = bcm_timer_init,
>  };
>  

This part will confict with the recent patches that kill off the
struct sys_timer, but it should be easy to fix.

	Arnd
