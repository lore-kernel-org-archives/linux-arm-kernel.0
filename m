From: sudipm.mukherjee@gmail.com (Sudip Mukherjee)
Date: Fri, 27 May 2016 14:30:48 +0530
Subject: [PATCH] hwrng: stm32 - fix build warning
In-Reply-To: <7211115.EdoBLRGZ1i@wuerfel>
References: <1464007448-25395-1-git-send-email-sudipm.mukherjee@gmail.com>
 <6297051.TAxtzW5OIB@wuerfel> <5745085D.6000104@gmail.com>
 <7211115.EdoBLRGZ1i@wuerfel>
Message-ID: <57480CC0.80500@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 May 2016 03:36 PM, Arnd Bergmann wrote:
> On Wednesday, May 25, 2016 7:35:17 AM CEST Sudip Mukherjee wrote:
>> On Tuesday 24 May 2016 02:05 AM, Arnd Bergmann wrote:
>>> On Monday, May 23, 2016 6:14:08 PM CEST Sudip Mukherjee wrote:
>>>> We have been getting build warning about:
>>>> drivers/char/hw_random/stm32-rng.c: In function 'stm32_rng_read':
>>>> drivers/char/hw_random/stm32-rng.c:82:19: warning: 'sr' may be used
>>>>                                       uninitialized in this function
>>>>
>>>> On checking the code it turns out that sr can never be used
>>>> uninitialized as sr is getting initialized in the while loop and while
>>>> loop will always execute as the minimum value of max can be 32.
>>>> So just initialize sr to 0 while declaring it to silence the compiler.
>>>>
>>>> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
>>>> ---
>>>
>snip>
>
> BTW, regarding your build infrastructure, I'd also recommend building
> with 'make -s' to make the output more compact.

travis is having a timeout and if there is no output from the build 
within a time limit then it will cancel the build. I can use the option 
if i can increase the timeout limit. I will have a look at the options. 
Thanks for the idea.

Regards
Sudip
