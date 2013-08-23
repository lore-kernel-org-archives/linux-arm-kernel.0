From: tony@atomide.com (Tony Lindgren)
Date: Thu, 22 Aug 2013 22:51:52 -0700
Subject: [PATCH] ARM: VExpress: Kconfig: avoid arm6 compatible for
 ARCH_VEXPRESS
In-Reply-To: <5216D31B.9050609@asianux.com>
References: <521479B4.8030604@asianux.com> <52147AC6.9040300@asianux.com>
 <52147E12.4060401@asianux.com> <20130822074524.GS7656@atomide.com>
 <20130822102210.GF25647@n2100.arm.linux.org.uk>
 <5216BF16.2080006@asianux.com> <5216C389.9050605@asianux.com>
 <5216D138.6080802@asianux.com> <5216D31B.9050609@asianux.com>
Message-ID: <20130823055152.GY7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Chen Gang <gang.chen@asianux.com> [130822 20:20]:
> The related error:
> 
>   /tmp/ccOMIprI.s: Assembler messages:
>   /tmp/ccOMIprI.s:507: Error: selected processor does not support ARM mode `isb '
>   /tmp/ccOMIprI.s:513: Error: selected processor does not support ARM mode `isb '
>   /tmp/ccOMIprI.s:514: Error: selected processor does not support ARM mode `dsb '
>   /tmp/ccOMIprI.s:584: Error: selected processor does not support ARM mode `isb '
>   /tmp/ccOMIprI.s:590: Error: selected processor does not support ARM mode `isb '
>   /tmp/ccOMIprI.s:591: Error: selected processor does not support ARM mode `dsb '
>   make[1]: *** [arch/arm/mach-vexpress/dcscb.o] Error 1
>   make: *** [arch/arm/mach-vexpress] Error 2
> 
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/arm/mach-vexpress/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
> index 3657954..9b176ce 100644
> --- a/arch/arm/mach-vexpress/Kconfig
> +++ b/arch/arm/mach-vexpress/Kconfig
> @@ -1,5 +1,5 @@
>  config ARCH_VEXPRESS
> -	bool "ARM Ltd. Versatile Express family" if ARCH_MULTI_V7
> +	bool "ARM Ltd. Versatile Express family" if ARCH_MULTI_V7 && !CPU_V6 && !CPU_V6K
>  	select ARCH_REQUIRE_GPIOLIB
>  	select ARM_AMBA
>  	select ARM_GIC

We do support v6 and v7 in the same kernel. So instead of limiting
what to select in Kconfig, just specify the v7 flags in the Makefile
for the vexpress .c file with the inline assembly. Look for the
find command I posted earlier in this thread for examples of specifying 
flags for a single object in a makefile.

Regards,

Tony
