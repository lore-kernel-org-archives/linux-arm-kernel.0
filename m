From: josh.wu@atmel.com (Josh Wu)
Date: Wed, 27 Jun 2012 12:11:17 +0800
Subject: [PATCH v11 0/4] MTD: at91: Add PMECC support for at91 nand flash
 driver
In-Reply-To: <1340768981.2317.7.camel@koala>
References: <1340618866-28776-1-git-send-email-josh.wu@atmel.com>
 <1340768981.2317.7.camel@koala>
Message-ID: <4FEA87E5.9010604@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Artem

On 6/27/2012 11:49 AM, Artem Bityutskiy wrote:
> On Mon, 2012-06-25 at 18:07 +0800, Josh Wu wrote:
>> Those patches is based on v3.5-rc4
>>
>> Changes since v10,
>> 	add one more patch in this patch set, which add 'int' return value for write_page()/write_page_raw() functions in structure of nand_ecc_ctrl.
>> 	Instead of calling BUG(), atmel_nand_pmecc_write_page() will return -EIO when time out to read the pmecc status register.
>> 	increase the time-out duration to 100ms, which has more toleration.
>> 	add oob_required argument for pmecc read/write functions to align with v3.5-rc4.
> I have issues compiling l2-mtd.git tree (based on 3.5-rc5) with the
> attached defconfig. Probably not your fault, but may be you have a
> fix/suggestion? I did not have time to look closer. Aiaiai reports:

I think the name of kernel config for AT91 is changed, so you can try 
add following two line in your original config file.

CONFIG_SOC_AT91SAM9=y
CONFIG_SOC_AT91RM9200=y

run the make menuconfig will get new config, that can pass the compile.

>
> Failed to build the following commit for configuration "arm-at91cap9_defconfig" (architecture arm)":
>
> bb6ac5c Quick fixes - applied by aiaiai
>
> include/linux/math64.h:55:15: note: each undeclared identifier is reported only once for each function it appears in
> In file included from include/linux/mm_types.h:16:0,
>                   from include/linux/sched.h:64,
>                   from arch/arm/kernel/asm-offsets.c:13:
> arch/arm/include/asm/page.h: At top level:
> arch/arm/include/asm/page.h:107:2: error: #error Unknown user operations model
> In file included from include/linux/mm.h:44:0,
>                   from arch/arm/kernel/asm-offsets.c:14:
> arch/arm/include/asm/pgtable.h:198:5: warning: "__LINUX_ARM_ARCH__" is not defined [-Wundef]
> In file included from arch/arm/include/asm/cacheflush.h:15:0,
>                   from arch/arm/kernel/asm-offsets.c:16:
> arch/arm/include/asm/glue-cache.h:129:2: error: #error Unknown cache maintenance model
> In file included from arch/arm/include/asm/cacheflush.h:17:0,
>                   from arch/arm/kernel/asm-offsets.c:16:
> arch/arm/include/asm/cachetype.h:28:5: warning: "__LINUX_ARM_ARCH__" is not defined [-Wundef]
> arch/arm/include/asm/cachetype.h:33:7: warning: "__LINUX_ARM_ARCH__" is not defined [-Wundef]
> In file included from arch/arm/kernel/asm-offsets.c:16:0:
> arch/arm/include/asm/cacheflush.h:194:7: warning: "__LINUX_ARM_ARCH__" is not defined [-Wundef]
> arch/arm/include/asm/cacheflush.h:196:7: warning: "__LINUX_ARM_ARCH__" is not defined [-Wundef]
> In file included from arch/arm/kernel/asm-offsets.c:17:0:
> arch/arm/include/asm/glue-df.h:99:2: error: #error Unknown data abort handler type
> In file included from arch/arm/kernel/asm-offsets.c:18:0:
> arch/arm/include/asm/glue-pf.h:54:2: error: #error Unknown prefetch abort handler type
> make[2]: *** [arch/arm/kernel/asm-offsets.s] Error 1
>
>
>

Best Regards,
Josh Wu
