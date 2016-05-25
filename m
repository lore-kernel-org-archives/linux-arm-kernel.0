From: sudipm.mukherjee@gmail.com (Sudip Mukherjee)
Date: Wed, 25 May 2016 07:35:17 +0530
Subject: [PATCH] hwrng: stm32 - fix build warning
In-Reply-To: <6297051.TAxtzW5OIB@wuerfel>
References: <1464007448-25395-1-git-send-email-sudipm.mukherjee@gmail.com>
 <6297051.TAxtzW5OIB@wuerfel>
Message-ID: <5745085D.6000104@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 May 2016 02:05 AM, Arnd Bergmann wrote:
> On Monday, May 23, 2016 6:14:08 PM CEST Sudip Mukherjee wrote:
>> We have been getting build warning about:
>> drivers/char/hw_random/stm32-rng.c: In function 'stm32_rng_read':
>> drivers/char/hw_random/stm32-rng.c:82:19: warning: 'sr' may be used
>> 					uninitialized in this function
>>
>> On checking the code it turns out that sr can never be used
>> uninitialized as sr is getting initialized in the while loop and while
>> loop will always execute as the minimum value of max can be 32.
>> So just initialize sr to 0 while declaring it to silence the compiler.
>>
>> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
>> ---
>
> I notice that you are using a really old compiler. While this warning
> seems to be valid in the sense that the compiler should figure out that
> the variable might be used uninitialized, please update your toolchain
> before reporting other such problems, as gcc-4.6 had a lot more false
> positives that newer ones (5.x or 6.x) have.

yes, i need to upgrade gcc in my travis bot. But in my local system I am 
having gcc-4.8.4 and there also I am having this error and i am sure 
4.8.4 is still being used by many people.

Regards
Sudip
