From: treding@nvidia.com (Thierry Reding)
Date: Tue, 29 Jul 2014 10:26:46 +0200
Subject: linux-next: manual merge of the gpio tree with the arm-soc tree
In-Reply-To: <20140729181949.427a7fb5@canb.auug.org.au>
References: <20140729181949.427a7fb5@canb.auug.org.au>
Message-ID: <20140729082645.GC31360@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 29, 2014 at 10:19:49AM +0200, Stephen Rothwell wrote:
> * PGP Signed by an unknown key
> 
> Hi Linus,
> 
> Today's linux-next merge of the gpio tree got a conflict in
> arch/arm/mach-tegra/board-paz00.c between commit a0524acc94c9 ("ARM:
> tegra: Sort includes alphabetically") from the arm-soc tree and commit
> 0a6d315827ee ("gpio: split gpiod board registration into machine
> header") from the gpio tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).
> 
> -- 
> Cheers,
> Stephen Rothwell                    sfr at canb.auug.org.au
> 
> diff --cc arch/arm/mach-tegra/board-paz00.c
> index bb4782a32713,91fd858ced0d..000000000000
> --- a/arch/arm/mach-tegra/board-paz00.c
> +++ b/arch/arm/mach-tegra/board-paz00.c
> @@@ -17,10 -17,9 +17,10 @@@
>    *
>    */
>   
> - #include <linux/gpio/driver.h>
>  -#include <linux/platform_device.h>
> + #include <linux/gpio/machine.h>
>  +#include <linux/platform_device.h>
>   #include <linux/rfkill-gpio.h>
>  +
>   #include "board.h"
>   
>   static struct rfkill_gpio_platform_data wifi_rfkill_platform_data = {

Looks good to me.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140729/f74a1cb2/attachment.sig>
