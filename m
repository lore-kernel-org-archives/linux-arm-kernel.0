From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 2 Dec 2014 15:53:51 +0800
Subject: [PATCH] ARM: imx: set system_rev value
In-Reply-To: <1416484385-22501-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1416484385-22501-1-git-send-email-vladimir_zapolskiy@mentor.com>
Message-ID: <20141202075350.GB2411@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 20, 2014 at 01:53:05PM +0200, Vladimir Zapolskiy wrote:
> Set system_rev value to chip silicon version USB_ANALOG_DIGPROG.
> 
>   root at mx6q:~# cat /proc/cpuinfo | grep Revision
>   Revision	: 630002
> 
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

Such info can be found by checking soc_id and revision under
/sys/devices/soc0/.

Shawn

> ---
>  arch/arm/mach-imx/anatop.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/anatop.c b/arch/arm/mach-imx/anatop.c
> index 8259a62..505100f 100644
> --- a/arch/arm/mach-imx/anatop.c
> +++ b/arch/arm/mach-imx/anatop.c
> @@ -15,6 +15,7 @@
>  #include <linux/of_address.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/regmap.h>
> +#include <asm/system_info.h>
>  #include "common.h"
>  #include "hardware.h"
>  
> @@ -123,6 +124,7 @@ void __init imx_init_revision_from_anatop(void)
>  
>  	mxc_set_cpu_type(digprog >> 16 & 0xff);
>  	imx_set_soc_revision(revision);
> +	system_rev = digprog & 0xffffff;
>  }
>  
>  void __init imx_anatop_init(void)
> -- 
> 1.7.10.4
> 
