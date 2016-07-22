From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 22 Jul 2016 16:36:41 +0100
Subject: [PATCH] arm64: Kconfig: select ALPINE_MSI only if PCI is selected
In-Reply-To: <20160722152730.GC6397@kwain>
References: <1469198527-12525-1-git-send-email-sudeep.holla@arm.com>
 <20160722152730.GC6397@kwain>
Message-ID: <180e7e82-13cc-7fda-fbb1-2f2b43e75271@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 22/07/16 16:27, Antoine Tenart wrote:
> Hello,
>
> On Fri, Jul 22, 2016 at 03:42:07PM +0100, Sudeep Holla wrote:
>> Even when PCI is disabled, ARCH_ALPINE selects ALPINE_MSI triggerring
>> the following config warning:
>>
>> warning: (ARCH_ALPINE) selects ALPINE_MSI which has unmet direct dependencies (PCI)
>>
>> This patch makes selection of ALPINE_MSI conditional on PCI.
>
> [...]
>
>> --- a/arch/arm64/Kconfig.platforms
>> +++ b/arch/arm64/Kconfig.platforms
>> @@ -8,7 +8,7 @@ config ARCH_SUNXI
>>
>>  config ARCH_ALPINE
>>  	bool "Annapurna Labs Alpine platform"
>> -	select ALPINE_MSI
>> +	select ALPINE_MSI if PCI
>>  	help
>>  	  This enables support for the Annapurna Labs Alpine
>>  	  Soc family.
>
> ALPINE_MSI also depends on PCI_MSI (which itself depends on PCI).

ALPINE_MSI now selects PCI_MSI

> PCI_MSI isn't necessarily selected when PCI is, so please make the

Yes but ALPINE_MSI does it now as I mentioned above.

> ALPINE_MSI selection conditional on PCI_MSI instead.
>

I will wait for Arnd's response if that's OK as he seem to have made
some changes around this recently.

-- 
Regards,
Sudeep
