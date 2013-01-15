From: florian@openwrt.org (Florian Fainelli)
Date: Tue, 15 Jan 2013 11:23:27 +0100
Subject: [PATCH 1/6] arm: mvebu: Add support for USB host controllers
 in Armada 370/XP
In-Reply-To: <1358243670-11935-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1358243670-11935-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <50F52E1F.8010702@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Ezequiel,

Le 01/15/13 10:54, Ezequiel Garcia a ?crit :
> diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
> index 440b13e..5e4fcde 100644
> --- a/arch/arm/mach-mvebu/Kconfig
> +++ b/arch/arm/mach-mvebu/Kconfig
> @@ -24,6 +24,7 @@ config MACH_ARMADA_370_XP
>   	select HAVE_SMP
>   	select CACHE_L2X0
>   	select CPU_PJ4B
> +	select USB_ARCH_HAS_EHCI if USB_SUPPORT

I do not think this is actually required because ARCH_MVEBU selects 
PLAT_ORION and in drivers/usb/host/Kconfig, USB_ARCH_HAS_EHCI is default 
y if PLAT_ORION. Having USB_ARCH_HAS_EHCI without USB_SUPPORT enabled is 
pretty harmless.
--
Florian
