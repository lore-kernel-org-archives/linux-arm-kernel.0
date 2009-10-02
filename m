From: walsimou@walsimou.com (Gaye Abdoulaye Walsimou)
Date: Fri, 02 Oct 2009 23:52:30 +0200
Subject: [PATCH] s3c2440: mini2440 buildfix
In-Reply-To: <20091001133431.GH28928@trinity.fluff.org>
References: <1254403894-9404-1-git-send-email-gadiyar@ti.com>
	<20091001133431.GH28928@trinity.fluff.org>
Message-ID: <4AC6761E.8040708@walsimou.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben Dooks wrote:
> On Thu, Oct 01, 2009 at 07:01:34PM +0530, Anand Gadiyar wrote:
>   
>> s3c2440: mini2440 buildfix
>>
>> Fix the following two build errors seen with mini2440_defconfig:
>>
>>   CC      arch/arm/plat-s3c24xx/cpu.o
>> arch/arm/plat-s3c24xx/cpu.c:84: error: 's3c2410a_init' undeclared here (not in a function)
>> make[1]: *** [arch/arm/plat-s3c24xx/cpu.o] Error 1
>> make: *** [arch/arm/plat-s3c24xx] Error 2
>>
>>   LD      .tmp_vmlinux1
>> arch/arm/mach-s3c2440/built-in.o:(.init.data+0x724): undefined reference to `s3c_device_usb'
>> make: *** [.tmp_vmlinux1] Error 1
>>
>> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
>> CC: Gaye Abdoulaye Walsimou <walsimou@walsimou.com>
>> CC: Ben Dooks <ben-linux@fluff.org>
>> ---
>> The latter error was reported by Gaye Abdoulaye Walsimou.
>> I hit the former error while attempting to fix it.
>>
>> I don't have this board, so I do not know if this is correct.
>> Build-tested only.
>>
>> - Anand
>>
>> diff --git a/arch/arm/mach-s3c2440/Kconfig b/arch/arm/mach-s3c2440/Kconfig
>> index d7bba91..64f9e6d 100644
>> --- a/arch/arm/mach-s3c2440/Kconfig
>> +++ b/arch/arm/mach-s3c2440/Kconfig
>> @@ -102,6 +102,7 @@ config MACH_MINI2440
>>  	select EEPROM_AT24
>>  	select LEDS_TRIGGER_BACKLIGHT
>>  	select SND_S3C24XX_SOC_S3C24XX_UDA134X
>> +	select S3C_DEV_USB_HOST
>>  	select S3C_DEV_NAND
>>  	help
>>  	  Say Y here to select support for the MINI2440. Is a 10cm x 10cm board
>>     
>
> Yes, this is the fix for this one.
>
>   
>> diff --git a/arch/arm/plat-s3c24xx/include/plat/s3c2410.h b/arch/arm/plat-s3c24xx/include/plat/s3c2410.h
>> index b6deeef..82ab4aa 100644
>> --- a/arch/arm/plat-s3c24xx/include/plat/s3c2410.h
>> +++ b/arch/arm/plat-s3c24xx/include/plat/s3c2410.h
>> @@ -27,6 +27,7 @@ extern void s3c2410_init_clocks(int xtal);
>>  #define s3c2410_init_uarts NULL
>>  #define s3c2410_map_io NULL
>>  #define s3c2410_init NULL
>> +#define s3c2410a_init NULL
>>  #endif
>>     
>
> this one we've already got a fix queued, awaiting feedback on the 
> s3c64xx fixes before pushing upstream.
>
>   
Thanks for these fix!
I didn't notice the second one,  but I've already submitted similar
patch for the first!

Regards,
