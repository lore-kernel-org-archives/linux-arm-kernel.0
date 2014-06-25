From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 25 Jun 2014 09:09:08 -0700
Subject: [PATCH v2] sched: Fix compiler warnings
In-Reply-To: <20140625155259.GQ14781@pengutronix.de>
References: <1403658329-13196-1-git-send-email-linux@roeck-us.net>
 <20140625071416.GM14781@pengutronix.de> <53AADC63.8080106@roeck-us.net>
 <20140625144955.GP14781@pengutronix.de> <53AAE4D2.5020104@roeck-us.net>
 <063D6719AE5E284EB5DD2968C1650D6D17265D81@AcuExch.aculab.com>
 <20140625155259.GQ14781@pengutronix.de>
Message-ID: <53AAF424.6010302@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25/2014 08:52 AM, Uwe Kleine-K?nig wrote:
> Hello,
>
> On Wed, Jun 25, 2014 at 03:40:28PM +0000, David Laight wrote:
>> From: Guenter Roeck
>>> Actually turns out one can use __attribute_const__, and it is
>>>
>>> 	static inline int __attribute_const__ cpu_corepower_flags(void)
>>>
>>> which turns out to be widely used.
>>>
>>> I'll change that and resubmit after testing.
>>
>> You don't need to tell the compiler that for an inline function.
> I didn't check for the functions in question here, but in general your
> statement is wrong.
>
> For example:
>
> static inline unsigned int __attribute_const__ read_cpuid_id(void)
> {
> 	return readl(BASEADDR_V7M_SCB + V7M_SCB_CPUID);
> }
>
> from arch/arm/include/asm/cputype.h. The V7M_SCB_CPUID register never
> changes, but there is no way gcc can deduce that.
>

Sigh. As I mentioned earlier, it is much easier to introduce a problem
than to fix it.

Ok, I'll leave this alone. I already spent much more time on this than
I should or have, so it is really time to move on.

Guenter
