From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 20 Jan 2012 10:23:50 -0600
Subject: [PATCH] ep93xx: Convert the watchdog driver into a platform
 device.
In-Reply-To: <20120120093149.GX27296@infomag.iguana.be>
References: <201201191701.30836.hartleys@visionengravers.com>
 <20120120093149.GX27296@infomag.iguana.be>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F3F9D067EB@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, January 20, 2012 2:32 AM, Wim Van Sebroeck wrote:
>>  void ep93xx_restart(char mode, const char *cmd) diff --git 
>> a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h 
>> b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
>> index c4a7b84..e9271a7 100644
>> --- a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
>> +++ b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
>> @@ -224,6 +224,7 @@
>>  #define EP93XX_SYSCON_SYSCFG_LCSN1	(1<<0)
>>  #define EP93XX_SYSCON_SWLOCK		EP93XX_SYSCON_REG(0xc0)
>>  
>> +#define EP93XX_WATCHDOG_PHYS_BASE	EP93XX_APB_PHYS(0x00140000)
>>  #define EP93XX_WATCHDOG_BASE		EP93XX_APB_IOMEM(0x00140000)
>
> Shouldn't this last define be removed after you added the new PHYS_BASE ?

To make it easier on Ryan's other patches I left it for now.

After this patch and Ryan's others are applied I will go through the defines in
the soc.h header and figure out which ones can be removed.

Thanks,
Hartley
