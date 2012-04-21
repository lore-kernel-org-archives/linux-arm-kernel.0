From: viresh.linux@gmail.com (viresh kumar)
Date: Sat, 21 Apr 2012 17:57:08 +0530
Subject: [PATCH 1/9] SPEAr13xx: Add header files
In-Reply-To: <201204201752.05657.arnd@arndb.de>
References: <cover.1334942163.git.viresh.kumar@st.com>
 <7c9115d4111ddc27f9088e668dbca409bebc9e70.1334942163.git.viresh.kumar@st.com>
 <201204201752.05657.arnd@arndb.de>
Message-ID: <CAOh2x=ncefojSYBPUVgL1EKcQ+wPFzfCmo+TZ+3BEmwD+=Q=Gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/20/12, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 20 April 2012, Viresh Kumar wrote:
>> diff --git a/arch/arm/mach-spear13xx/include/mach/irqs.h
>> b/arch/arm/mach-spear13xx/include/mach/irqs.h
>> new file mode 100644
>> index 0000000..ddf5721
>> --- /dev/null
>> +++ b/arch/arm/mach-spear13xx/include/mach/irqs.h
>> @@ -0,0 +1,23 @@
>> +
>> +#ifndef __MACH_IRQS_H
>> +#define __MACH_IRQS_H
>> +
>> +#define IRQ_LOCALTIMER			29
>
> I think we can now probe localtimer from devicetree so you should
> not need this one any more.

Done in V2.

>> +#define SPEAR13XX_IRQ_GPT0_TMR0		69
>> +#define SPEAR13XX_IRQ_GPT0_TMR1		70
>
> I'd also prefer if you could add bindings for GPT and probe
> these interrupts and the GPT address from the devicetree
> for the three spear platforms, that would make the code much
> nicer in this area.

Done in V2.

>> +#define PERIP_GRP2_BASE				UL(0xB3000000)
>> +#define VA_PERIP_GRP2_BASE			UL(0xFE000000)
>> +#define MCIF_SDHCI_BASE				UL(0xB3000000)
>> +#define SYSRAM0_BASE				UL(0xB3800000)

> Can you go through this list one more time and check which ones are
> still needed here? I think most of them can just get removed.

Yes. Removed whatever is not used currently.

>> +/* RAS Area Control Register */
>> +#define SPEAR1310_RAS_CTRL_REG0			(VA_SPEAR1310_RAS_BASE + 0x000)
>> +	#define SPEAR1310_GPT64_SYNC_ENB		0
>> +	#define SPEAR1310_GPT64_SYNC_ENB_MASK		1
>> +	#define SPEAR1310_GPT64_SYNC_ENB_SHIFT		31
>> +	#define SPEAR1310_SSP1_CS_SEL_CS0		0
>> +	#define SPEAR1310_SSP1_CS_SEL_CS1		1
>> +	#define SPEAR1310_SSP1_CS_SEL_MASK		3
>> +	#define SPEAR1310_SSP1_CS_SEL_SHIFT		30
>> +	#define SPEAR1310_SSP1_CS_VAL_MASK		1
>> +	#define SPEAR1310_SSP1_CS_VAL_SHIFT		28
>> +	#define SPEAR1310_SSP1_CS_CTL_HW		0
>> +	#define SPEAR1310_SSP1_CS_CTL_SW		1
>
> Why are the RAS control registers in a global header? It looks like you
> only use them from the clock driver, so they can be moved into a local
> header file there.

Actually registers serves many different features. Clock, software controlled
chip selects for spi, etc. So really can't move to clock drivers.

I didn't wanted half part of a register in one file and other half in other.
So kept them here, so that these are accessible from all users.

--
viresh
