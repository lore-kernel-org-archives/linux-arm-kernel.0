From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 9 Nov 2012 07:27:39 +1100
Subject: linux-next: manual merge of the arm-soc tree with the l2-mtd
 and pinctrl trees
In-Reply-To: <201211081511.54467.arnd@arndb.de>
References: <20121107142916.824003a6c863320fbf379652@canb.auug.org.au>
 <201211081511.54467.arnd@arndb.de>
Message-ID: <20121109072739.bb0f97bb571e66add1810d18@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thu, 8 Nov 2012 15:11:54 +0000 Arnd Bergmann <arnd@arndb.de> wrote:
>
> I think this one turned out wrong, and is missing this part:
> 
> diff --git a/arch/arm/mach-nomadik/board-nhk8815.c b/arch/arm/mach-nomadik/board-nhk8815.c
> index 5ccdf53..69769b7 100644
> --- a/arch/arm/mach-nomadik/board-nhk8815.c
> +++ b/arch/arm/mach-nomadik/board-nhk8815.c
> @@ -26,7 +26,6 @@
>  #include <linux/pinctrl/machine.h>
>  #include <linux/platform_data/pinctrl-nomadik.h>
>  #include <linux/platform_data/clocksource-nomadik-mtu.h>
> -#include <linux/platform_data/mtd-nomadik-nand.h>
>  #include <asm/hardware/vic.h>
>  #include <asm/sizes.h>
>  #include <asm/mach-types.h>
> 
> 
> The mtd-nomadik-nand.h inclusion was removed in the l2-mtd tree, but
> moved to a different line in the arm-soc tree. It needs to be removed
> because the header is gone now.

Thanks for that.  I have now fixed up my fix up :-)

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121109/f7ec4720/attachment.sig>
