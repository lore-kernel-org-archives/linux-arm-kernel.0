From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 24 Apr 2012 08:58:54 +0530
Subject: New ARM build coverage
In-Reply-To: <201204201737.58922.arnd@arndb.de>
References: <CAP=VYLrNpskLQDAw3Udnq7grddi-uD6TDjQQoZUd+FVg2rXPnA@mail.gmail.com>
 <201204201737.58922.arnd@arndb.de>
Message-ID: <4F961DF6.9030504@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/20/2012 11:07 PM, Arnd Bergmann wrote:
>>From d06bce2084e946c3ae4dc3011032d0c23b7cd815 Mon Sep 17 00:00:00 2001
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Fri, 20 Apr 2012 19:33:55 +0200
> Subject: [PATCH] ARM: spear6xx: remove board selection options
> 
> There are no board specific configurations that need user
> intervention, so just make MACH_SPEAR600 the silent default
> for ARCH_SPEAR6XX to prevent users from turning it off, which
> would result in a build error.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> diff --git a/arch/arm/mach-spear6xx/Kconfig b/arch/arm/mach-spear6xx/Kconfig
> index fbe298b..339f397 100644
> --- a/arch/arm/mach-spear6xx/Kconfig
> +++ b/arch/arm/mach-spear6xx/Kconfig
> @@ -2,21 +2,9 @@
>  # SPEAr6XX Machine configuration file
>  #
>  
> -if ARCH_SPEAR6XX
> -
> -menu "SPEAr6xx Implementations"
> -config BOARD_SPEAR600_DT
> -	bool "SPEAr600 generic board configured via device-tree"
> -	select MACH_SPEAR600
> +config MACH_SPEAR600
> +	def_bool y
> +	depends on ARCH_SPEAR6XX
>  	select USE_OF
>  	help
>  	  Supports ST SPEAr600 boards configured via the device-tree
> -
> -endmenu
> -
> -config MACH_SPEAR600
> -	bool "SPEAr600"
> -	help
> -	  Supports ST SPEAr600 Machine
> -
> -endif #ARCH_SPEAR6XX

Acked-by: Viresh Kumar <viresh.kumar@st.com>

-- 
viresh
