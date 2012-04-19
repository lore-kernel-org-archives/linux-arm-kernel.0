From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 19 Apr 2012 10:25:36 +0200
Subject: [PATCH] ARM: SAMSUNG: Should check for IS_ERR(clk) instead of NULL
In-Reply-To: <4F8F586C.3020401@samsung.com>
References: <1334722134-14545-1-git-send-email-jhbird.choi@samsung.com>
 <4F8F586C.3020401@samsung.com>
Message-ID: <4F8FCC00.10807@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/19/2012 02:12 AM, Kukjin Kim wrote:
>> --- a/arch/arm/plat-samsung/include/plat/watchdog-reset.h
>> +++ b/arch/arm/plat-samsung/include/plat/watchdog-reset.h
>> @@ -25,7 +25,7 @@ static inline void arch_wdt_reset(void)
>>
>>   	__raw_writel(0, S3C2410_WTCON);	  /* disable watchdog, to be safe  */
>>
>> -	if (s3c2410_wdtclk)
>> +	if (!IS_ERR(s3c2410_wdtclk))
> 
> Yeah, right. BTW don't we need to check NULL here?

It might make sense to check for NULL as well, but only if it happens
that a clock entry is ever added to clkdev with null struct clk_lookup:clk
member. This in turn seems impossible with the current clock code at
plat-samsung/clock.c.

>>   		clk_enable(s3c2410_wdtclk);
>>
>>   	/* put initial values into count and data */

--
Regards,
Sylwester
