From: robherring2@gmail.com (Rob Herring)
Date: Fri, 21 Oct 2011 15:09:31 -0500
Subject: [GIT PULL] GIC DT binding support
In-Reply-To: <4024688.X5RT0XjWMI@wuerfel>
References: <4E97A601.1020005@gmail.com> <4EA03160.1050304@gmail.com>
	<201110201812.29202.arnd@arndb.de> <4024688.X5RT0XjWMI@wuerfel>
Message-ID: <4EA1D17B.8090003@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/21/2011 03:51 AM, Arnd Bergmann wrote:
> On Thursday 20 October 2011 18:12:28 Arnd Bergmann wrote:
>> I've now rebased your tree on top of 3.1-rc9 plus the stable branches
>> from Russell's tree that I already have as dependencies in arm-soc/for-next
>> (devel-stable, smp, debug). This has caused no conflicts for me, but
>> that doesn't mean that it's correct. Please check that what I have
>> in arm-soc/dt/gic and arm-soc/highbank/soc actually works for you
>> and does not contain branches that you don't actually need.
> 
> I needed this patch in the end:
> 
> 8<-----
> ARM: gic: fix build error with CONFIG_IRQ_DOMAIN disabled
> 
> In file included from arch/arm/mach-msm/timer.c:26:0:
> asm/hardware/gic.h:42:50: warning: 'struct device_node' declared inside parameter list [enabled by default]
> asm/hardware/gic.h:42:50: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]
> asm/hardware/gic.h:58:20: error: field 'domain' has incomplete type
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Ok to apply on top?

Okay.

> 
> diff --git a/arch/arm/include/asm/hardware/gic.h b/arch/arm/include/asm/hardware/gic.h
> index 1a776a1..a06c3ac 100644
> --- a/arch/arm/include/asm/hardware/gic.h
> +++ b/arch/arm/include/asm/hardware/gic.h
> @@ -35,6 +35,8 @@
>  #ifndef __ASSEMBLY__
>  #include <linux/irqdomain.h>
>  
> +struct device_node;
> +

You don't actually need this line.

Thanks,
Rob
