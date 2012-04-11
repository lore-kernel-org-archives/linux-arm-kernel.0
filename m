From: rmallon@gmail.com (Ryan Mallon)
Date: Wed, 11 Apr 2012 12:09:14 +1000
Subject: [PATCH] arm: ep93xx: Don't try to release not acquired GPIO lines
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F002069840A362@AUSP01VMBX24.collaborationhost.net>
References: <4F7D8587.5020205@metasoft.pl>
 <ADE657CA350FB648AAC2C43247A983F002069840A362@AUSP01VMBX24.collaborationhost.net>
Message-ID: <4F84E7CA.8000508@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/04/12 02:39, H Hartley Sweeten wrote:

> On Thursday, April 05, 2012 4:44 AM, Rafal Prylowski wrote:
>> Fail path of ep93xx_keypad_acquire_gpio() tries to release
>> GPIO lines not acquired successfully before. Fix this.
>>
>> Signed-off-by: Rafal Prylowski <prylowski@metasoft.pl>
>> Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
>> Cc: Ryan Mallon <rmallon@gmail.com>
>>
>> ---
>> Patch applies to v3.4rc1.
>>
>>  arch/arm/mach-ep93xx/core.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Index: linux-2.6/arch/arm/mach-ep93xx/core.c
>> ===================================================================
>> --- linux-2.6.orig/arch/arm/mach-ep93xx/core.c
>> +++ linux-2.6/arch/arm/mach-ep93xx/core.c
>> @@ -734,7 +734,7 @@ int ep93xx_keypad_acquire_gpio(struct pl
>>  fail_gpio_d:
>>  	gpio_free(EP93XX_GPIO_LINE_C(i));
>>  fail_gpio_c:
>> -	for ( ; i >= 0; --i) {
>> +	for (--i; i >= 0; --i) {
>>  		gpio_free(EP93XX_GPIO_LINE_C(i));
>>  		gpio_free(EP93XX_GPIO_LINE_D(i));
>>  	}
> 
> Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>


Applied to ep93xx-fixes on https://github.com/RyanMallon/linux-ep93xx

Thanks,
~Ryan
