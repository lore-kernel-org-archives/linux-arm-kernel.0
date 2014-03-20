From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 20 Mar 2014 17:52:39 +0530
Subject: [PATCH 06/62] ARM: davinci: export da8xx_syscfg0_base
In-Reply-To: <201403201257.56090.arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <4836281.0IgPinItBq@wuerfel> <532AB3CF.30806@ti.com>
 <201403201257.56090.arnd@arndb.de>
Message-ID: <532ADD8F.6020608@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 March 2014 05:27 PM, Arnd Bergmann wrote:
> On Thursday 20 March 2014, Sekhar Nori wrote:

>> diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
>> index 3586460..c807d3f 100644
>> --- a/drivers/usb/host/ohci-hcd.c
>> +++ b/drivers/usb/host/ohci-hcd.c
>> @@ -1178,7 +1178,8 @@ MODULE_LICENSE ("GPL");
>>  #define SA1111_DRIVER          ohci_hcd_sa1111_driver
>>  #endif
>>  
>> -#ifdef CONFIG_ARCH_DAVINCI_DA8XX
>> +/* DA8XX uses platform internal symbols. Cannot be built as module. */
>> +#if defined(CONFIG_ARCH_DAVINCI_DA8XX) && !defined(CONFIG_USB_OHCI_HCD_MODULE)
>>  #include "ohci-da8xx.c"
>>  #define DAVINCI_PLATFORM_DRIVER        ohci_hcd_da8xx_driver
>>  #endif
> 
> I wouldn't want to submit that patch to GregKH ;-)
> 
> How about doing the same thing in a somewhat less sneaky way?
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Much better! Please feel free to add

Acked-by: Sekhar Nori <nsekhar@ti.com>

if it helps.

Regards,
Sekhar
