From: robherring2@gmail.com (Rob Herring)
Date: Mon, 12 Nov 2012 08:03:48 -0600
Subject: [PATCH] ARM: implement optimized percpu variable access
In-Reply-To: <20121112132811.GF2346@mudshark.cambridge.arm.com>
References: <1352604040-10014-1-git-send-email-robherring2@gmail.com>
 <20121112102354.GA2346@mudshark.cambridge.arm.com>
 <50A0F390.7060800@gmail.com>
 <20121112132811.GF2346@mudshark.cambridge.arm.com>
Message-ID: <50A101C4.9090807@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12/2012 07:28 AM, Will Deacon wrote:
> On Mon, Nov 12, 2012 at 01:03:12PM +0000, Rob Herring wrote:
>> On 11/12/2012 04:23 AM, Will Deacon wrote:
>>>> +static inline void set_my_cpu_offset(unsigned long off)
>>>> +{
>>>> +	asm volatile("mcr p15, 0, %0, c13, c0, 4	@ set TPIDRPRW" : : "r" (off) : "cc" );
>>>> +}
>>>
>>> You don't need the "cc" here.
>>
>> You would think so, but the compiler drops this instruction if you
>> don't. set_cr does the same thing.
> 
> Whoa, that sounds suspicious... if the thing is marked volatile GCC
> shouldn't optimise it away if it's reachable. Which toolchain are you
> using?

Ubuntu 12.10 ARM cross compiler:
gcc version 4.7.2 (Ubuntu/Linaro 4.7.2-1ubuntu1)

Rob
