From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 09 Dec 2014 19:20:00 -0800
Subject: [PATCH v2 3/4] ARM: mach-bcm: Enable I2C support for iProc
In-Reply-To: <5487AEF0.5010404@broadcom.com>
References: <Ray Jui <rjui@broadcom.com>
 <1418177893-22094-1-git-send-email-rjui@broadcom.com>
 <1418177893-22094-4-git-send-email-rjui@broadcom.com>
 <5487ADE5.4070705@gmail.com> <5487AEF0.5010404@broadcom.com>
Message-ID: <5487BBE0.4000701@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/14 18:24, Ray Jui wrote:
> 
> 
> On 12/9/2014 6:20 PM, Florian Fainelli wrote:
>> On 09/12/14 18:18, Ray Jui wrote:
>>> Enable I2C driver support for Broadcom iProc family of SoCs by
>>> selecting I2C_BCM_IPROC
>>>
>>> Signed-off-by: Ray Jui <rjui@broadcom.com>
>>> Reviewed-by: Scott Branden <sbranden@broadcom.com>
>>> ---
>>>   arch/arm/mach-bcm/Kconfig |    1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
>>> index aaeec78..86ee90b 100644
>>> --- a/arch/arm/mach-bcm/Kconfig
>>> +++ b/arch/arm/mach-bcm/Kconfig
>>> @@ -19,6 +19,7 @@ config ARCH_BCM_IPROC
>>>       select ARCH_REQUIRE_GPIOLIB
>>>       select ARM_AMBA
>>>       select PINCTRL
>>> +    select I2C_BCM_IPROC
>>
>> One way to avoid having to modify mach-bcm/Kconfig would be to have your
>> i2c driver Kconfig do this:
>>
>> default ARCH_BCM_IPROC
>>
>> would that work?
>>
> Yes. So in which case it is better to select a driver from the
> architecture specific Kconfig?

I suppose if your driver/subsystem is critical for system boot, like
powering a regulator or something that has a critical purpose, a select
is probably more appropriate here. If this is just exposing non-critical
devices, I would go with a depends on/default at the driver Kconfig level.

This is just how I see things, others would definitively have a
different view.

> 
>>>       help
>>>         This enables support for systems based on Broadcom IPROC
>>> architected SoCs.
>>>         The IPROC complex contains one or more ARM CPUs along with
>>> common
>>>
>>
