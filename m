From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 8 Mar 2012 17:17:16 +1100
Subject: linux-next: manual merge of the arm-soc tree with the  tree
In-Reply-To: <20120308170303.c113c6c34b8a7ae95caeb592@canb.auug.org.au>
References: <20120308170303.c113c6c34b8a7ae95caeb592@canb.auug.org.au>
Message-ID: <20120308171716.67ef72a3b195ef25f1d781d6@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

Sorry for the cut and paste mess ... :-(

On Thu, 8 Mar 2012 17:03:03 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
> 
> Today's linux-next merge of the arm-soc tree got a conflict in arch/arm/mach-omap1/board-palmz71.c between commit  ("") from the  tree and commit  ("") from the arm-soc tree.
> Today's linux-next merge of the arm-soc tree got a conflict in
> arch/arm/mach-omap1/board-palmz71.c between commit ddba6c7f7ec6 ("OMAP1:
> pass LCD config with omapfb_set_lcd_config()") from the omap_dss2 tree
> and commit 2e3ee9f45b3c ("ARM: OMAP1: Move most of plat/io.h into local
> iomap.h") from the arm-soc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary.
> 
> -- 
> Cheers,
> Stephen Rothwell                    sfr at canb.auug.org.au
> 
> diff --cc arch/arm/mach-omap1/board-palmz71.c
> index 9924c70,c1cd0f2..0000000
> --- a/arch/arm/mach-omap1/board-palmz71.c
> +++ b/arch/arm/mach-omap1/board-palmz71.c
> @@@ -27,9 -27,9 +27,10 @@@
>   #include <linux/mtd/mtd.h>
>   #include <linux/mtd/partitions.h>
>   #include <linux/mtd/physmap.h>
>  +#include <linux/omapfb.h>
> + #include <linux/spi/spi.h>
> + #include <linux/spi/ads7846.h>
>   
> - #include <mach/hardware.h>
>   #include <asm/mach-types.h>
>   #include <asm/mach/arch.h>
>   #include <asm/mach/map.h>


-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120308/dd1a9395/attachment.sig>
