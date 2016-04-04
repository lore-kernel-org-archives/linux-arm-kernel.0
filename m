From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Mon, 04 Apr 2016 11:42:38 -0400
Subject: [PATCH for v4.7] arm: lpc32xx: remove leftovers of legacy
 clock source and provider drivers
In-Reply-To: <1456973180-31764-1-git-send-email-vz@mleia.com>
References: <1456973180-31764-1-git-send-email-vz@mleia.com>
Message-ID: <1459784558.25564.6.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On Thu, 2016-03-03 at 04:46 +0200, Vladimir Zapolskiy wrote:
> After switching the platform to common clock framework there is no
> more need to keep dead code in arch/arm/mach-lpc32xx, which glued
> legacy clock source and clock provider drivers, remove the leftovers.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  arch/arm/mach-lpc32xx/common.c | 95 ------------------------------------------
>  arch/arm/mach-lpc32xx/common.h | 23 +---------
>  2 files changed, 1 insertion(+), 117 deletions(-)
> 
> diff --git a/arch/arm/mach-lpc32xx/common.h b/arch/arm/mach-lpc32xx/common.h
> index 1cd8853..f03683f 100644
> --- a/arch/arm/mach-lpc32xx/common.h
> +++ b/arch/arm/mach-lpc32xx/common.h
> @@ -19,38 +19,17 @@
>  
>  #include <linux/reboot.h>
>  
It is possible to remove "reboot.h";
do you want me to send a separate patch for it?

>  extern void lpc23xx_restart(enum reboot_mode, const char *);
>  
The patch does not apply on 4.6-rc1;
can you send a version 2 of your patch based on the latest mainline?


Sylvain
