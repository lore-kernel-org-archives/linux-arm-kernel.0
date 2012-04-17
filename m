From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 17 Apr 2012 10:21:09 +0100
Subject: [PATCH v3 2/6] ARM: local timers: Add A15 architected timer
 support
In-Reply-To: <4F8C5A9C.9000506@codeaurora.org>
References: <1334592810-4382-1-git-send-email-marc.zyngier@arm.com>
 <1334592810-4382-3-git-send-email-marc.zyngier@arm.com>
 <4F8C5A9C.9000506@codeaurora.org>
Message-ID: <4F8D3605.5010308@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/04/12 18:45, Stephen Boyd wrote:

Hi Stephen,

> On 04/16/12 09:13, Marc Zyngier wrote:
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index cf006d4..68c382d 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -1543,6 +1543,13 @@ config HAVE_ARM_SCU
>>  	help
>>  	  This option enables support for the ARM system coherency unit
>>  
>> +config ARM_ARCH_TIMER
>> +	bool "Architected timer support"
>> +	depends on CPU_V7
>> +	select TICK_ONESHOT
> 
> I believe TICK_ONESHOT is a "hidden" option that should not be selected
> outside the generic clockevents layer. It seems Russell and Thomas have
> talked about this too, see 3872c48 (tick: Document TICK_ONESHOT config
> option, 2012-03-31).

Ah, thanks for noticing this. I'm glad this point has been clarified.
I'll push a fix.

	M.
-- 
Jazz is not dead. It just smells funny...
