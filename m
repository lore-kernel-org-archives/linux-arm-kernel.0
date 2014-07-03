From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 3 Jul 2014 22:23:12 +0800
Subject: [PATCH] ARM: imx: imx6sx uses imx6q cpuidle code
In-Reply-To: <6439884.YMH7C85FhG@wuerfel>
References: <6439884.YMH7C85FhG@wuerfel>
Message-ID: <20140703142311.GF30239@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 03, 2014 at 04:16:06PM +0200, Arnd Bergmann wrote:
> Building a kernel for imx6sx but without imx6q support results in
> this link error because of the missing cpuidle driver:
> 
> arch/arm/mach-imx/built-in.o: In function `imx6sx_init_late'::(.init.text+0xc228):
>  undefined reference to `imx6q_cpuidle_init'
> 
> This patch adds a Makefile entry so we always build support for
> the imx6q_cpuidle code when at least one of the 6sx or 6q variants
> are enabled.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the fixing, Arnd.  Applied.

Shawn

> 
> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> index a364e20..d0179cd 100644
> --- a/arch/arm/mach-imx/Makefile
> +++ b/arch/arm/mach-imx/Makefile
> @@ -31,6 +31,7 @@ ifeq ($(CONFIG_CPU_IDLE),y)
>  obj-$(CONFIG_SOC_IMX5) += cpuidle-imx5.o
>  obj-$(CONFIG_SOC_IMX6Q) += cpuidle-imx6q.o
>  obj-$(CONFIG_SOC_IMX6SL) += cpuidle-imx6sl.o
> +obj-$(CONFIG_SOC_IMX6SX) += cpuidle-imx6q.o
>  endif
>  
>  ifdef CONFIG_SND_IMX_SOC
> 
