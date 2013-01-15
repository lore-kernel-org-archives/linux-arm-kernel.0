From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 15 Jan 2013 07:49:45 -0300
Subject: [PATCH 1/6] arm: mvebu: Add support for USB host controllers
 in Armada 370/XP
In-Reply-To: <50F52E1F.8010702@openwrt.org>
References: <1358243670-11935-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <50F52E1F.8010702@openwrt.org>
Message-ID: <50F53449.8090001@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

On 01/15/2013 07:23 AM, Florian Fainelli wrote:
> Le 01/15/13 10:54, Ezequiel Garcia a ?crit :
>> diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
>> index 440b13e..5e4fcde 100644
>> --- a/arch/arm/mach-mvebu/Kconfig
>> +++ b/arch/arm/mach-mvebu/Kconfig
>> @@ -24,6 +24,7 @@ config MACH_ARMADA_370_XP
>>       select HAVE_SMP
>>       select CACHE_L2X0
>>       select CPU_PJ4B
>> +    select USB_ARCH_HAS_EHCI if USB_SUPPORT
> 
> I do not think this is actually required because ARCH_MVEBU selects PLAT_ORION and in drivers/usb/host/Kconfig, USB_ARCH_HAS_EHCI is default y if PLAT_ORION. Having USB_ARCH_HAS_EHCI without USB_SUPPORT enabled is pretty harmless.

Yes, you're right, this is not needed.

Nice catch and thanks for the review,

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
