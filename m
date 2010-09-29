From: hashim.kernel@gmail.com (hashim alig)
Date: Wed, 29 Sep 2010 11:36:52 +0530
Subject: High Latency in PL310 L2 cache maintenance operations
In-Reply-To: <1285685447.14312.2.camel@e102109-lin.cambridge.arm.com>
References: <AANLkTinMYZmzy=J1TOEPs6dKs2gCwzazECop_riK2nwd@mail.gmail.com>
	<1285685358.14312.1.camel@e102109-lin.cambridge.arm.com>
	<1285685447.14312.2.camel@e102109-lin.cambridge.arm.com>
Message-ID: <AANLkTik5G2mW6D8f6XpKFffbY1OxYLO3n05H+Q3rUvT7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Catalin,

On Tue, Sep 28, 2010 at 8:20 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Tue, 2010-09-28 at 15:49 +0100, Catalin Marinas wrote:
>> On Tue, 2010-09-28 at 14:25 +0100, hashim alig wrote:
>> > I am using linux-2.6.32 kernel on a platform which is ARM-Cortex A9
>> > SMP (dual core, each at 500 MHz) with PL310 as the L2 cache. I observe
>> > high latency in cache maintainance operations (both invalidation and
>> > clean) which is around 90 cycles for every cache line (32 bytes).
>> > Is it normal? What should be the practical range ?
>> > I also tried with linux-2.6.35 over which I applied few L2 patches
>> > from Catalin but observation remains same.
>>
>> Have you applied this patch from Will Deacon:
>>
>> http://www.linux-arm.org/git?p=linux-2.6-stable.git;a=commitdiff;h=c3d0fd52ce0c36836aefd53ce9b25f193daa2e5e

NO. But I have played with latencies.

> Forgot to mention - this patch is for Versatile Express, you would need
> to do something similar in your platform. We can't really set the
> default values in the l2x0 code since these latencies depend on the
> hardware configuration.

OK. I have actually played with latency registers but saw no
improvement, even the system
became unstable.
Following is the ideal configuration of PL310 registers (as reported
by h/w designers) and on which L2 and system is stable.

Auxillary Control Reg (0x104) - 0x02060000
Tag RAM Latency (0x108)     - 0x00000110
Data RAM Latency (0x10C)   - 0x00000220

One more thing, port filtering at L2 is enabled with following configuration
Addr filtering start (offset 0xc00)    -    0x1
Addr filtering end (offset 0xc04)    -    0x08000000

regards
Shiraz
