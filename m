From: rmallon@gmail.com (Ryan Mallon)
Date: Sat, 14 Jan 2012 08:46:39 +1100
Subject: [PATCH 08/11] ep93xx: Move EP93XX_WATCHDOG_BASE define to driver
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F001F3F99EBB0B@AUSP01VMBX24.collaborationhost.net>
References: <1326251676-7593-1-git-send-email-rmallon@gmail.com>
 <1326251676-7593-9-git-send-email-rmallon@gmail.com>
 <ADE657CA350FB648AAC2C43247A983F001F3F99EBB0B@AUSP01VMBX24.collaborationhost.net>
Message-ID: <4F10A63F.1050100@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/01/12 04:45, H Hartley Sweeten wrote:
> On Tuesday, January 10, 2012 8:15 PM, Ryan Mallon wrote:
>> The EP93xx watchdog driver is the only user of this define, move it there.
>>
>> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
>> Cc: Mika Westerberg <mika.westerberg@iki.fi>
>> Cc: Wim Van Sebroeck <wim@iguana.be>
>> Signed-off-by: Ryan Mallon <rmallon@gmail.com>
>> ---
>>  arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |    2 --
>>  drivers/watchdog/ep93xx_wdt.c                   |    1 +
>>  2 files changed, 1 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
>> index 387f745..225790d 100644
>> --- a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
>> +++ b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
>> @@ -127,7 +127,5 @@
>>  #define EP93XX_SYSCON_SYSCFG_LCSN1	(1<<0)
>>  #define EP93XX_SYSCON_SWLOCK		EP93XX_SYSCON_REG(0xc0)
>>  
>> -#define EP93XX_WATCHDOG_BASE		EP93XX_APB_IOMEM(0x00140000)
>> -
>>  
>>  #endif
>> diff --git a/drivers/watchdog/ep93xx_wdt.c b/drivers/watchdog/ep93xx_wdt.c index 726b7df..82f648a 100644
>> --- a/drivers/watchdog/ep93xx_wdt.c
>> +++ b/drivers/watchdog/ep93xx_wdt.c
>> @@ -49,6 +49,7 @@ static unsigned long boot_status;
>>  #define WDT_IN_USE		0
>>  #define WDT_OK_TO_CLOSE		1
>>  
>> +#define EP93XX_WATCHDOG_BASE	EP93XX_APB_IOMEM(0x00140000)
>>  #define EP93XX_WDT_REG(x)	(EP93XX_WATCHDOG_BASE + (x))
>>  #define EP93XX_WDT_WATCHDOG	EP93XX_WDT_REG(0x00)
>>  #define EP93XX_WDT_WDSTATUS	EP93XX_WDT_REG(0x04)
> Ryan,
>
> I have a patch to convert the watchdog driver to a platform device and
> use the WatchDog Timer Driver Core.  This patch will end up moving the
> base define to soc.h instead. But, for now, this looks good.

Is your patch ready to go? I'm in no rush to get these patches in, and I
can add it to this series if you like, which would get rid of the need
for this patch and would also mean that we don't need the include of
<mach/ep93xx-regs.h> in the watchdog driver in the final patch.

Thanks,
~Ryan
