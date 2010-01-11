From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 11 Jan 2010 13:31:28 -0500
Subject: [PATCH] ep93xx: define magic numbers for pll1 and pll2
In-Reply-To: <4B4A795C.8000507@bluewatersys.com>
References: <BD79186B4FD85F4B8E60E381CAEE19090200F622@mi8nycmail19.Mi8.com>
	<4B4A795C.8000507@bluewatersys.com>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190902089912@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, January 10, 2010 6:06 PM, Ryan Mallon wrote:
> H Hartley Sweeten wrote:
>> Add defines for the pll register magic numbers that determine if
>> the pll's are bypassed and if pll2 is enabled.  Rename the clock
>> set registers to more closely match the datasheet.  Also, remove
>> the unnecessary braces since each conditional statement is a single
>> statement.
>> 
>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>> Cc: Ryan Mallon <ryan@bluewatersys.com>
>> 
>> ---
>>

[snip]
 
>> diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
>> index d55194a..cd35912 100644
>> --- a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
>> +++ b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
>> @@ -167,8 +167,11 @@
>>  #define EP93XX_SYSCON_PWRCNT_DMA_M2P1	(1<<16)
>>  #define EP93XX_SYSCON_HALT		EP93XX_SYSCON_REG(0x08)
>>  #define EP93XX_SYSCON_STANDBY		EP93XX_SYSCON_REG(0x0c)
>> -#define EP93XX_SYSCON_CLOCK_SET1	EP93XX_SYSCON_REG(0x20)
>> -#define EP93XX_SYSCON_CLOCK_SET2	EP93XX_SYSCON_REG(0x24)
>> +#define EP93XX_SYSCON_CLKSET1		EP93XX_SYSCON_REG(0x20)
>> +#define EP93XX_SYSCON_CLKSET1_NBYP1	(1<<23)
>> +#define EP93XX_SYSCON_CLKSET2		EP93XX_SYSCON_REG(0x24)
>> +#define EP93XX_SYSCON_CLKSET2_NBYP2	(1<<19)
>> +#define EP93XX_SYSCON_CLKSET2_PLL2_EN	(1<<18)
>>  #define EP93XX_SYSCON_DEVCFG		EP93XX_SYSCON_REG(0x80)
>>  #define EP93XX_SYSCON_DEVCFG_SWRST	(1<<31)
>>  #define EP93XX_SYSCON_DEVCFG_D1ONG	(1<<30) 
>
> Looks okay. If the clock registers are only ever used inside clock.c
> should we move them there to cut down the size of ep93xx-regs.h?

For right now I would like to keep all the 'SYSCON' defines in the header.
All of the other peripherals have a specific driver that it makes sense to
move the register defines into and then access them using the offset from
the base address.  The SysCon registers are a bit unique in that many
subsystems need access for various reasons.

Eventually a lot of them can be moved into clock.c but for right now
lets just leave them in the header.

Is that an Acked-by?

Regards,
Hartley
