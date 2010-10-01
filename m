From: hashim.kernel@gmail.com (hashim alig)
Date: Fri, 1 Oct 2010 17:16:16 +0530
Subject: High Latency in PL310 L2 cache maintenance operations
In-Reply-To: <1285750502.4497.4.camel@e102109-lin.cambridge.arm.com>
References: <AANLkTinMYZmzy=J1TOEPs6dKs2gCwzazECop_riK2nwd@mail.gmail.com>
	<1285685358.14312.1.camel@e102109-lin.cambridge.arm.com>
	<1285685447.14312.2.camel@e102109-lin.cambridge.arm.com>
	<AANLkTik5G2mW6D8f6XpKFffbY1OxYLO3n05H+Q3rUvT7@mail.gmail.com>
	<1285750502.4497.4.camel@e102109-lin.cambridge.arm.com>
Message-ID: <AANLkTin=hYcYBKcLTid5cH=KPCssNRH3WC4xqOyqkAUX@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Catalin,

On Wed, Sep 29, 2010 at 2:25 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Wed, 2010-09-29 at 07:06 +0100, hashim alig wrote:
>> On Tue, Sep 28, 2010 at 8:20 PM, Catalin Marinas
>> <catalin.marinas@arm.com> wrote:
>> > On Tue, 2010-09-28 at 15:49 +0100, Catalin Marinas wrote:
>> >> On Tue, 2010-09-28 at 14:25 +0100, hashim alig wrote:
>> >> > I am using linux-2.6.32 kernel on a platform which is ARM-Cortex A9
>> >> > SMP (dual core, each at 500 MHz) with PL310 as the L2 cache. I observe
>> >> > high latency in cache maintainance operations (both invalidation and
>> >> > clean) which is around 90 cycles for every cache line (32 bytes).
>> >> > Is it normal? What should be the practical range ?
>> >> > I also tried with linux-2.6.35 over which I applied few L2 patches
>> >> > from Catalin but observation remains same.
>> >>
>> >> Have you applied this patch from Will Deacon:
>> >>
>> >> http://www.linux-arm.org/git?p=linux-2.6-stable.git;a=commitdiff;h=c3d0fd52ce0c36836aefd53ce9b25f193daa2e5e
>>
>> NO. But I have played with latencies.
>
> There are a couple of commits that made a difference in the L2
> maintenance - 0eb948dd7f7 and 3d1074349b (reducing the amount of
> spinlock operations, merged in 2.6.33). Do you have these applied?

I tried them along with
0a5f4cb2fc14026c3883aae6d6f6d5aaf9a0ae4a
ARM: Improve the L2 cache performance when PL310 is used
but still I am getting high latencies. To clean and invalidate 2048
bytes its is taking 11-12 usecs.
Surprisingly clean and invalidate(only)  operations are taking similar time.
I though that invalidation should take less cycles.

regards
Hashim
