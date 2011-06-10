From: simon@sequanux.org (Simon Guinot)
Date: Fri, 10 Jun 2011 13:45:08 +0000
Subject: [PATCH v2] ARM: kirkwood: Add support for Buffalo LS-XHL
In-Reply-To: <1307655488-12811-2-git-send-email-michael@walle.cc>
References: <1307655488-12811-1-git-send-email-michael@walle.cc>
	<1307655488-12811-2-git-send-email-michael@walle.cc>
Message-ID: <20110610134508.GL8223@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,

On Thu, Jun 09, 2011 at 11:38:08PM +0200, Michael Walle wrote:
> Add support for the Buffalo Linkstation XHL. This NAS box is based on a
> Marvell Kirkwood chip at 1.2 GHz and features 256 MB RAM, 512kb SPI boot
> flash, gigabit ethernet and one SATA port.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  arch/arm/configs/kirkwood_defconfig  |    1 +
>  arch/arm/mach-kirkwood/Kconfig       |    6 +
>  arch/arm/mach-kirkwood/Makefile      |    1 +
>  arch/arm/mach-kirkwood/lsxhl-setup.c |  313 ++++++++++++++++++++++++++++++++++
>  arch/arm/tools/mach-types            |    1 +
>  5 files changed, 322 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-kirkwood/lsxhl-setup.c
> 

... snip ...

> diff --git a/arch/arm/mach-kirkwood/lsxhl-setup.c b/arch/arm/mach-kirkwood/lsxhl-setup.c
> new file mode 100644
> index 0000000..783d257
> --- /dev/null
> +++ b/arch/arm/mach-kirkwood/lsxhl-setup.c
> @@ -0,0 +1,313 @@
> +/*
> + * arch/arm/mach-kirkwood/lsxhl-setup.c
> + *
> + * Buffalo LS-XHL Series Setup
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/mtd/physmap.h>
> +#include <linux/ata_platform.h>
> +#include <linux/spi/flash.h>
> +#include <linux/spi/spi.h>
> +#include <linux/mv643xx_eth.h>
> +#include <linux/gpio.h>
> +#include <linux/gpio_keys.h>
> +#include <linux/gpio-fan.h>
> +#include <linux/input.h>
> +#include <linux/leds.h>
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <mach/kirkwood.h>
> +#include <plat/mvsdio.h>

I think this include is unneeded.

... snip ...

> diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
> index 3b3776d..8acc587 100644
> --- a/arch/arm/tools/mach-types
> +++ b/arch/arm/tools/mach-types
> @@ -448,6 +448,7 @@ mityomapl138		MACH_MITYOMAPL138	MITYOMAPL138		2650
>  guruplug		MACH_GURUPLUG		GURUPLUG		2659
>  spear310		MACH_SPEAR310		SPEAR310		2660
>  spear320		MACH_SPEAR320		SPEAR320		2661
> +lsxhl			MACH_LSXHL		LSXHL			2663
>  aquila			MACH_AQUILA		AQUILA			2676
>  sheeva_esata		MACH_ESATA_SHEEVAPLUG	ESATA_SHEEVAPLUG	2678
>  msm7x30_surf		MACH_MSM7X30_SURF	MSM7X30_SURF		2679

You should probably ask the ARM maintainer to restore this machine
number entry.

BTW, I don't know if Nicolas will mainline this old fashioned board
setup. He is waiting for a DT alternative for Kirkwood.

Regards,

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110610/b7b123cc/attachment-0001.sig>
