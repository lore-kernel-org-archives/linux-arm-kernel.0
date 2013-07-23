From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 23 Jul 2013 19:02:36 +0100
Subject: updates for be8 patch series
In-Reply-To: <CAA3XUr2oDEDD6LFjnZ_N0JGTFUMDZG6O9b3JoeJ8AELrK2KDiw@mail.gmail.com>
References: <CAA3XUr3h5C0oJVrN5iXsM=NFkLMz_Tssp28CysZfwMNS5KvO-Q@mail.gmail.com>
 <51EEC002.9070808@codethink.co.uk>
 <CAA3XUr2oDEDD6LFjnZ_N0JGTFUMDZG6O9b3JoeJ8AELrK2KDiw@mail.gmail.com>
Message-ID: <51EEC53C.4080505@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/07/13 18:53, Victor Kamensky wrote:
> On 23 July 2013 10:40, Ben Dooks<ben.dooks@codethink.co.uk>  wrote:
>> On 23/07/13 18:24, Victor Kamensky wrote:
>>>
>>> Hi Ben,
>>>
>>> Wrt BE8 little endian instructions you will need to fix couple more
>>> places:
>>>       ftrace arch/arm/kernel/ftrace.c
>>>       kprobes arch/arm/kernel/kprobes.c
>>> Also in big endian mode atomic64_xxx function will need fixes, otherwise
>>> perf
>>> counters will be truncated on max of 32bit values
>>>       atomic64 arch/arm/include/asm/atomic.h
>>
>>
>> Hmm, thought ftrace already did the right endian-ness conversions,
>> although it is possible it could have missed one.
>>
>> The atomic instructions should work fine for BE8, they're using
>> STRD which should be correct.
>
> atomic64_read and atomic64_set are fine, but atomic64_add,
> atomic64_add_return, atomic64_sub, atomic64_sub_return, etc are not OK.
> The issue is in arithmetic operations not load/store.

I'm still surprised these don't work. What exact situation are you
seeing the failures in? Code would be very helpful here.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
