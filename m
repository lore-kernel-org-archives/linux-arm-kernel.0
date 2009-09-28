From: sbranden@broadcom.com (Scott Branden)
Date: Mon, 28 Sep 2009 11:58:29 -0700
Subject: [PATCH] Fix bcmring compile
In-Reply-To: <1254163190-2306-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <9383297B60843144AC17878B479520F110AEE538F9@SJEXCHCCR01.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org 
> [mailto:linux-arm-kernel-bounces at lists.infradead.org] On 
> Behalf Of Linus Walleij
> Sent: September 28, 2009 11:40 AM
> To: linux-arm-kernel at lists.infradead.org
> Cc: Linus Walleij
> Subject: [PATCH] Fix bcmring compile
> 
> The movement of the MMCI header file made bcmring break. It 
> turns out it was including asm/mmc.h without using it so 
> fixing the problem boils down to removing the offending include.
> 
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
>  arch/arm/mach-bcmring/core.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-bcmring/core.c 
> b/arch/arm/mach-bcmring/core.c index 492c649..b53b973 100644
> --- a/arch/arm/mach-bcmring/core.c
> +++ b/arch/arm/mach-bcmring/core.c
> @@ -45,7 +45,6 @@
>  #include <asm/mach/irq.h>
>  #include <asm/mach/time.h>
>  #include <asm/mach/map.h>
> -#include <asm/mach/mmc.h>
>  
>  #include <cfg_global.h>
>  
> --
> 1.6.2.1
> 
The core.c for bcmring was based on mach-versatile.
We missed removing this unused include.  
An easy fix - Thanks.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 
