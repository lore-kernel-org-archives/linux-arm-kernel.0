From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 08 Mar 2017 18:24:15 +0100
Subject: [PATCH 2/3] usb: host: Allow to build ehci orion with mvebu SoCs
In-Reply-To: <20170308170136.GC32355@lunn.ch> (Andrew Lunn's message of "Wed,
 8 Mar 2017 18:01:36 +0100")
References: <20170308162423.25553-1-gregory.clement@free-electrons.com>
 <20170308162423.25553-3-gregory.clement@free-electrons.com>
 <20170308170136.GC32355@lunn.ch>
Message-ID: <87o9xblm0w.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,
 
 On mer., mars 08 2017, Andrew Lunn <andrew@lunn.ch> wrote:

> On Wed, Mar 08, 2017 at 05:24:22PM +0100, Gregory CLEMENT wrote:
>> The mvebu ARM64 SoCs no more select PLAT_ORION but some of them as the
>> Armada 37xx use the EHCI orion controller. This patch allow to build
>> the driver when ARCH_MVEBU is selected.
>
> The mvebu ARM64 SoCs no longer selects PLAT_ORION.  However Armada
> 37xx use the Orion EHCI controller. This patch allows the Orion EHCI
> driver to be built when ARCH_MVEBU is selected.

Thanks for this enhancement!

>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>>  drivers/usb/host/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
>> index 407d947b34ea..870c42d89298 100644
>> --- a/drivers/usb/host/Kconfig
>> +++ b/drivers/usb/host/Kconfig
>> @@ -188,7 +188,7 @@ config USB_EHCI_HCD_OMAP
>>  
>>  config USB_EHCI_HCD_ORION
>>  	tristate  "Support for Marvell EBU on-chip EHCI USB controller"
>> -	depends on USB_EHCI_HCD && PLAT_ORION
>> +	depends on USB_EHCI_HCD && PLAT_ORION || ARCH_MVEBU
>
> I don't know the Kconfig language too well. Should this be:
>
>> +	depends on USB_EHCI_HCD && (PLAT_ORION || ARCH_MVEBU)

Your version seems better.

Thanks,

Gregory

>
>   Andrew
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
