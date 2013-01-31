From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 31 Jan 2013 09:19:55 -0500
Subject: [GIT PULL] ARM: mvebu cleanup for v3.9 round2
In-Reply-To: <201301311411.33125.arnd@arndb.de>
References: <1359495436.F88c4680.7559@triton>
 <20130131125116.GC7717@titan.lakedaemon.net>
 <201301311411.33125.arnd@arndb.de>
Message-ID: <20130131141955.GE7717@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 02:11:32PM +0000, Arnd Bergmann wrote:
> On Thursday 31 January 2013, Jason Cooper wrote:
> > Arnd, Olof,
> > 
> > Please don't pull this yet.  The nsa310 patch built fine at the tip of
> > my for-next, but didn't do so well when applied to mvebu/cleanup.
> > 
> > I'll redo and resubmit the whole series of pr's.
> 
> 
> FWIW, when I was building all defconfigs for for-next yesterday, I needed
> this patch, but nothing else for mvebu or kirkwood.

Yep, that was it.  Thanks!  in mvebu/dt we init i2c via DT, and
mvebu/cleanup is before that.

thx,

Jason.

> index 61c4b18..970174a 100644
> --- a/arch/arm/mach-kirkwood/board-nsa310.c
> +++ b/arch/arm/mach-kirkwood/board-nsa310.c
> @@ -11,6 +11,7 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/gpio.h>
> +#include <linux/i2c.h>
>  #include <mach/kirkwood.h>
>  #include <linux/of.h>
>  #include "common.h"
