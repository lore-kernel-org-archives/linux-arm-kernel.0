From: HartleyS@visionengravers.com (Hartley Sweeten)
Date: Mon, 14 Oct 2013 22:11:06 +0000
Subject: [PATCH] usb: ohci: remove ep93xx bus glue platform driver
In-Reply-To: <525C69AC.1010004@gmail.com>
References: <201310141435.31147.hartleys@visionengravers.com>
 <525C69AC.1010004@gmail.com>
Message-ID: <DC148C5AA1CEBA4E87973D432B1C2D8817DAC0CC@P3PWEX4MB008.ex4.secureserver.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, October 14, 2013 3:01 PM, Ryan Mallon wrote:
> On 15/10/13 08:35, H Hartley Sweeten wrote:
>> Convert ep93xx to use the OHCI platform driver and remove the
>> ohci-ep93xx bus glue driver.
>> 
>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>> Cc: Alan Stern <stern@rowland.harvard.edu>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Ryan Mallon <rmallon@gmail.com>
>> ---
>
>> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
>> index b3f20d7..2c8f2db 100644
>> --- a/drivers/usb/host/Kconfig
>> +++ b/drivers/usb/host/Kconfig
>> @@ -472,7 +472,7 @@ config USB_CNS3XXX_OHCI
>>  
>>  config USB_OHCI_HCD_PLATFORM
>>  	tristate "Generic OHCI driver for a platform device"
>> -	default n
>> +	default y if ARCH_EP93XX
>
> Shouldn't we select USB_OHCI_HCD_PLATFORM, e.g. something like:
>
> 	config ARCH_EP93XX_USB
>		tristate "USB OHCI support"
>		default y
>		select USB_OHCI_HCD_PLATFORM
>
> In arch/arm/mach-ep93xx/Kconfig rather than polluting
> drivers/usb/host/Kconfig with arch specific stuff?

I wasn't sure where the best place to enable 
USB_OHCI_HCD_PLATFORM would be.

Currently USB support on the EP93xx only needs USB_OHCI_HCD
enabled, which is already enabled in the ep93xx_defconfig. I'm not
sure if adding the config option above would create a problem where
the user would need to enable USB_OHCI_HCD in drivers/usb then 
have to go back to the arch stuff to enable ARCH_EP93XX_USB.

With the default y above they just have to enable USB_OHCI_HCD
like they currently do.

I'm hoping Alan can provide some feedback.

Regards,
Hartley
