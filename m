From: rogerq@ti.com (Roger Quadros)
Date: Wed, 9 Oct 2013 10:09:32 +0300
Subject: [PATCH] ARM: OMAP4: clock: Initialize USB DPLL
In-Reply-To: <alpine.DEB.2.02.1310090704180.30199@utopia.booyaka.com>
References: <1363873705-3224-1-git-send-email-rogerq@ti.com>
 <514B1553.6030701@ti.com>
 <alpine.DEB.2.02.1310090704180.30199@utopia.booyaka.com>
Message-ID: <5255012C.3050709@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/09/2013 10:05 AM, Paul Walmsley wrote:
> Hi Roger,
> 
> On Thu, 21 Mar 2013, Roger Quadros wrote:
> 
>> +Paul
>>
>> On 03/21/2013 03:48 PM, Roger Quadros wrote:
>>> If the bootloader doesn't configure USB DPLL (e.g. in u-boot,
>>> disable CONFIG_USB_EHCI_OMAP), then we get all sorts of problems
>>> like
>>> - division by zero errors at boot [1]
>>> - USB DPLL fails to enter locked state
>>> - USB EHCI Host is non functional
>>> - Device can't enter OFF mode
>>>
>>> Initializing the USB DPLL fixes all these issues.
> 
> Looks like I may have lost track of this - do we still need this one?

No, this is already in with the typo fix. Thanks.

> 
> Also:
> 
>>> diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap2/cclock44xx_data.c
>>> index bfc46c1..6127bb9 100644
>>> --- a/arch/arm/mach-omap2/cclock44xx_data.c
>>> +++ b/arch/arm/mach-omap2/cclock44xx_data.c
>>> @@ -53,6 +53,12 @@
>>>   */
>>>  #define OMAP4_DPLL_ABE_DEFFREQ				98304000
>>>  
>>> +/*
>>> + * OMAP4450 TRM Rev X, section "3.6.3.9.5 DPLL_USB Preferred Settings"
> 
> 4450?

cheers,
-roger
