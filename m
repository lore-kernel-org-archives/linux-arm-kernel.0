From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 11 Sep 2012 07:09:22 +0200
Subject: [PATCH] ARM: kirkwood: Trim excess #includes in board-dnskw.c
In-Reply-To: <1347287753-2805-1-git-send-email-jm@lentin.co.uk>
References: <1347287753-2805-1-git-send-email-jm@lentin.co.uk>
Message-ID: <20120911050922.GA6836@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2012 at 03:35:53PM +0100, Jamie Lentin wrote:
> Lots of code has now moved into the devicetree, leaving a collection of
> useless header files. Tidy them up.
> 
> This applies cleanly atop of my previous patch, "[PATCH V2 2/2] ARM:
> kirkwood: Use devicetree to define DNS-32[05] fan", which also removes
> gpio-fan.h
> 
> Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
> ---
>  arch/arm/mach-kirkwood/board-dnskw.c |    9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/arch/arm/mach-kirkwood/board-dnskw.c b/arch/arm/mach-kirkwood/board-dnskw.c
> index 6ac7a8d..43d16d6 100644
> --- a/arch/arm/mach-kirkwood/board-dnskw.c
> +++ b/arch/arm/mach-kirkwood/board-dnskw.c
> @@ -14,17 +14,8 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
> -#include <linux/ata_platform.h>
>  #include <linux/mv643xx_eth.h>
> -#include <linux/of.h>
>  #include <linux/gpio.h>
> -#include <linux/input.h>
> -#include <linux/leds.h>
> -#include <asm/mach-types.h>
> -#include <asm/mach/arch.h>
> -#include <asm/mach/map.h>
> -#include <mach/kirkwood.h>
> -#include <mach/bridge-regs.h>
>  #include "common.h"
>  #include "mpp.h"

Acked-by: Andrew Lunn <andrew@lunn.ch>

Hi Jamie

A minor point. I personally would of based this patch on top of a
plain -rc tag and not on top of the gpio-fan code. The gpio-fan code
might need more revisions before its acceptable, where as this change
is very likely to be accepted first time and is not controversial in
any way. So Jason is likely to apply this now, before the gpio-fan
code hits.

     Andrew
