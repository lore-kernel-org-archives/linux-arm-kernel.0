From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Sep 2016 09:54:26 +0200
Subject: [RFC PATCH v2 1/5] ARM: hisi: Make 3620 explicit, remove wildcards
In-Reply-To: <20160915210505.21878-2-netz.kernel@gmail.com>
References: <20160915210505.21878-1-netz.kernel@gmail.com>
 <20160915210505.21878-2-netz.kernel@gmail.com>
Message-ID: <3542593.NPVvbcgB79@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 15, 2016 4:05:01 PM CEST Marty Plummer wrote:
> --- a/arch/arm/mach-hisi/Kconfig
> +++ b/arch/arm/mach-hisi/Kconfig
> @@ -12,8 +12,8 @@ if ARCH_HISI
>  
>  menu "Hisilicon platform type"
>  
> -config ARCH_HI3xxx
> -       bool "Hisilicon Hi36xx family"
> +config ARCH_HI3620
> +       bool "Hisilicon Hi3620 family"
>         depends on ARCH_MULTI_V7
>         select CACHE_L2X0
>         select HAVE_ARM_SCU if SMP
> 

This breaks bisection by removing the ARCH_HI3xxx symbol that
the other drivers still rely on until the entire series is
applied.

I'd suggest introducing a hidden ARCH_HI3xxx symbol like

config ARCH_HI3xxx
	bool

config ARCH_HI3620
	bool "Hisilicon Hi3620 family"
	select ARCH_HI3xxx
	...

	Arnd
