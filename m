From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 25 Jun 2014 08:03:46 -0700
Subject: [PATCH v2] sched: Fix compiler warnings
In-Reply-To: <20140625144955.GP14781@pengutronix.de>
References: <1403658329-13196-1-git-send-email-linux@roeck-us.net>
 <20140625071416.GM14781@pengutronix.de> <53AADC63.8080106@roeck-us.net>
 <20140625144955.GP14781@pengutronix.de>
Message-ID: <53AAE4D2.5020104@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25/2014 07:49 AM, Uwe Kleine-K?nig wrote:
> Hello Guenter,
>
> On Wed, Jun 25, 2014 at 07:27:47AM -0700, Guenter Roeck wrote:
>>> Maybe the author's intention was:
>>>
>>> 	static inline int cpu_corepower_flags(void) __attribute__((const));
>>>
>>> ?
>>> This specifies that the function has no side effects and the return value
>>> only depends on the (here non-existing) function arguments.
>>>
>>
>> Possibly, but either I am missing something or this doesn't compile.
> You need to do a separate declaration:
>
> 	static inline int cpu_corepower_flags(void) __attribute__((const));
> 	static inline int cpu_corepower_flags(void)
> 	{
> 		...

Actually turns out one can use __attribute_const__, and it is

	static inline int __attribute_const__ cpu_corepower_flags(void)

which turns out to be widely used.

I'll change that and resubmit after testing.

Guenter
