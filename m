From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 31 May 2011 17:37:08 -0500
Subject: [PATCH] gpio: ep93xx: move driver to drivers/gpio
In-Reply-To: <BANLkTimzWyhZ14ieo0SUfsn8SKp9cM_EBw@mail.gmail.com>
References: <201105311249.30372.hartleys@visionengravers.com>
	<BANLkTimzWyhZ14ieo0SUfsn8SKp9cM_EBw@mail.gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F381FC4A77@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, May 31, 2011 1:41 PM, Grant Likely wrote:
> On Tue, May 31, 2011 at 1:49 PM, H Hartley Sweeten wrote:
>> The GPIO driver should reside in drivers/gpio.
>>
>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>> Cc: Ryan Mallon <ryan@bluewatersys.com>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>>
>> ---
>>
>> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
>> index 342d634..7307302 100644
>> --- a/drivers/gpio/Kconfig
>> +++ b/drivers/gpio/Kconfig
>> @@ -86,6 +86,13 @@ config GPIO_IT8761E
>> ? ? ? ?help
>> ? ? ? ? ?Say yes here to support GPIO functionality of IT8761E super I/O chip.
>>
>> +config GPIO_EP93XX
>> + ? ? ? bool "Cirrus EP93xx GPIO support"
>> + ? ? ? depends on ARCH_EP93XX
>> + ? ? ? default y
>> + ? ? ? help
>> + ? ? ? ? Say yes here to support the Cirrus EP93xx GPIO peripheral.
>> +
>
> Do you really want a user-visible Kconfig symbol here?  If it cannot
> be built as a module, then I suspect that for most on-chip gpio
> controllers they should just be enabled unconditionally on the SoC's
> Kconfig symbol.

Grant,

No, I a user-visible symbol is not needed.  Should I change this to:

+config GPIO_EP93XX
+ ? ? ? bool
+ ? ? ? depends on ARCH_EP93XX
+ ? ? ? default y

Or like the Samsung drivers, without the visibility:

+config GPIO_EP93XX
+ ? ? ? bool
+ ? ? ? depends on ARM
+ ? ? ? default y if ARCH_EP93XX

Also, should the help information remain with a hidden Kconfig symbol?

Thanks,
Hartley
