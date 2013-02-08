From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 08 Feb 2013 14:45:28 -0800
Subject: [PATCH] ARM: S3C24XX: osiris: add missing platform_device.h
 include
In-Reply-To: <201302052250.18818.heiko@sntech.de>
References: <201302052250.18818.heiko@sntech.de>
Message-ID: <1a5a01ce064d$ff75c600$fe615200$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner wrote:
> 
> The missing include led to a implcit declaration warning.
> 
Yes, this fixes following:

In file included from arch/arm/mach-s3c24xx/mach-osiris.c:34:0:
include/linux/platform_data/i2c-s3c2410.h:37:26: warning: 'struct platform_device' declared inside parameter list [enabled by default]
include/linux/platform_data/i2c-s3c2410.h:37:26: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]
include/linux/platform_data/i2c-s3c2410.h:66:38: warning: 'struct platform_device' declared inside parameter list [enabled by default]
include/linux/platform_data/i2c-s3c2410.h:67:38: warning: 'struct platform_device' declared inside parameter list [enabled by default]
include/linux/platform_data/i2c-s3c2410.h:68:38: warning: 'struct platform_device' declared inside parameter list [enabled by default]
include/linux/platform_data/i2c-s3c2410.h:69:38: warning: 'struct platform_device' declared inside parameter list [enabled by default]
include/linux/platform_data/i2c-s3c2410.h:70:38: warning: 'struct platform_device' declared inside parameter list [enabled by default]
include/linux/platform_data/i2c-s3c2410.h:71:38: warning: 'struct platform_device' declared inside parameter list [enabled by default]
include/linux/platform_data/i2c-s3c2410.h:72:38: warning: 'struct platform_device' declared inside parameter list [enabled by default]
include/linux/platform_data/i2c-s3c2410.h:73:38: warning: 'struct platform_device' declared inside parameter list [enabled by default]

Applied with adding fixed warning message.

Thanks.

- Kukjin

> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/arm/mach-s3c24xx/mach-osiris.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-s3c24xx/mach-osiris.c b/arch/arm/mach-
> s3c24xx/mach-osiris.c
> index c2dc032..7d73626 100644
> --- a/arch/arm/mach-s3c24xx/mach-osiris.c
> +++ b/arch/arm/mach-s3c24xx/mach-osiris.c
> @@ -21,6 +21,7 @@
>  #include <linux/clk.h>
>  #include <linux/i2c.h>
>  #include <linux/io.h>
> +#include <linux/platform_device.h>
> 
>  #include <linux/i2c/tps65010.h>
> 
> --
> 1.7.10.4
