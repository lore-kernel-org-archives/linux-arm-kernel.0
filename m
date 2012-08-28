From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 28 Aug 2012 11:11:39 +0200
Subject: [PATCH] mtd: orion_nand: remove <mach/hardware.h> include
In-Reply-To: <1346110528-30858-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <20120816183708.GT22226@titan.lakedaemon.net>
 <1346110528-30858-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1346110528-30858-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20120828091139.GC31704@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2012 at 01:35:28AM +0200, Thomas Petazzoni wrote:
> Commit c085d965fb63ac3b4cc7379d45588c0b39e2bdb0 made the ARCH_MVEBU
> platform select PLAT_ORION, which means that now all Orion drivers can
> be enabled on ARCH_MVEBU. This works fine for most drivers, except for
> orion_nand, because it includes <mach/hardware.h>, but mach-mvebu does
> not have a mach/hardware.h header (it is considered as a deprecated
> practice).
> 
> It turns out that the <mach/hardware.h> include in orion_nand is not
> necessary: the driver builds perfectly fine without it, so we simply
> get rid of it.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: linux-mtd at lists.infradead.org
> Cc: Artem Bityutskiy <dedekind1@gmail.com>
> ---
>  drivers/mtd/nand/orion_nand.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/orion_nand.c b/drivers/mtd/nand/orion_nand.c
> index fc5a868..9ee436d 100644
> --- a/drivers/mtd/nand/orion_nand.c
> +++ b/drivers/mtd/nand/orion_nand.c
> @@ -21,7 +21,6 @@
>  #include <linux/err.h>
>  #include <asm/io.h>
>  #include <asm/sizes.h>
> -#include <mach/hardware.h>
>  #include <plat/orion_nand.h>
>  
>  static void orion_nand_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
> -- 
> 1.7.9.5
> 

Hi Thomas

I compiled tested on Dove, Kirkwood, Orion5x and mv78xx0.

Tested-by: Andrew Lunn <andrew@lunn.ch>

One other driver you might want to look at is:

drivers/watchdog/orion_wdt.c

It uses <mach/bridge-regs.h>

   Andrew
