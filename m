From: ryan@bluewatersys.com (Ryan Mallon)
Date: Mon, 14 Jun 2010 17:36:28 +1200
Subject: [PATCH 2/5] SPEAR3xx: Rename register/irq defines to remove naming
	conflicts
In-Reply-To: <4C15BB99.4060108@st.com>
References: <1275717955-14545-1-git-send-email-ryan@bluewatersys.com>
	<1275717955-14545-3-git-send-email-ryan@bluewatersys.com>
	<4C15BB99.4060108@st.com>
Message-ID: <4C15BFDC.70809@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Viresh KUMAR wrote:
> On 6/5/2010 11:35 AM, Ryan Mallon wrote:
>> Prefix register and irq defintions to remove naming conflicts between
>> the three SPEAr3xx platforms.
>>
>> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
>> ---
>>  arch/arm/mach-spear3xx/include/mach/generic.h  |    4 +-
>>  arch/arm/mach-spear3xx/include/mach/irqs.h     |  195 ++++++++++++------------
>>  arch/arm/mach-spear3xx/include/mach/spear300.h |   26 ++--
>>  arch/arm/mach-spear3xx/include/mach/spear310.h |   44 +++---
>>  arch/arm/mach-spear3xx/include/mach/spear320.h |   50 +++---
>>  arch/arm/mach-spear3xx/spear300.c              |   65 ++++----
>>  arch/arm/mach-spear3xx/spear310.c              |   92 ++++++------
>>  arch/arm/mach-spear3xx/spear320.c              |  134 ++++++++--------
>>  arch/arm/mach-spear3xx/spear3xx.c              |    4 +-
>>  9 files changed, 308 insertions(+), 306 deletions(-)
>>
>> diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
>> index af7e02c..48dfb9c 100644
>> --- a/arch/arm/mach-spear3xx/include/mach/generic.h
>> +++ b/arch/arm/mach-spear3xx/include/mach/generic.h
>> @@ -27,8 +27,8 @@
>>   * Following GPT channels will be used as clock source and clockevent
>>   */
>>  #define SPEAR_GPT0_BASE		SPEAR3XX_ML1_TMR_BASE
>> -#define SPEAR_GPT0_CHAN0_IRQ	IRQ_CPU_GPT1_1
>> -#define SPEAR_GPT0_CHAN1_IRQ	IRQ_CPU_GPT1_2
>> +#define SPEAR_GPT0_CHAN0_IRQ	SPEAR3XX_IRQ_CPU_GPT1_1
>> +#define SPEAR_GPT0_CHAN1_IRQ	SPEAR3XX_IRQ_CPU_GPT1_2
>>  

<snip>

> 
> We have kept it, the way it was intentionally. I don't understand why any
> conflicts will occur.

The goal of the patch series is to allow all a single kernel to have
support for all of the spear platforms, ie CONFIG_MACH_SPEAR300,
CONFIG_MACH_SPEAR310 and CONFIG_MACH_SPEAR320 can all be set.

The current code has duplicate defines in
arch/arm/mach-spear3xx/include/mach/spear3[012]0.h which means that
these three files cannot be included at once (they are included from
arch/arm/mach-spear3xx/include/mach/spear.h).

~Ryan
