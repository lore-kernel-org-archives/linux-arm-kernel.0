From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 30 Nov 2012 09:18:18 +0100
Subject: [PATCH] ARM: sunxi: add missing include for mdelay()
In-Reply-To: <20121130013730.GA30592@beefymiracle.amer.corp.natinst.com>
References: <20121130013730.GA30592@beefymiracle.amer.corp.natinst.com>
Message-ID: <50B86BCA.7050103@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 30/11/2012 02:37, Josh Cartwright a ?crit :
>   CC      arch/arm/mach-sunxi/sunxi.o
> ./arch/arm/mach-sunxi/sunxi.c: In function 'sunxi_restart':
> ./arch/arm/mach-sunxi/sunxi.c:55:3: error: implicit declaration of function 'mdelay' [-Werror=implicit-function-declaration]
> 
> Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

> ---
> Fixes multiplatform build error seen with today's linux-next-20121129.
> 
>  arch/arm/mach-sunxi/sunxi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
> index dc634ae..9be910f 100644
> --- a/arch/arm/mach-sunxi/sunxi.c
> +++ b/arch/arm/mach-sunxi/sunxi.c
> @@ -10,6 +10,7 @@
>   * warranty of any kind, whether express or implied.
>   */
>  
> +#include <linux/delay.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/of_address.h>
> 


-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
