From: alex.shi@linaro.org (Alex Shi)
Date: Tue, 10 Dec 2013 14:08:17 +0800
Subject: questions of cpuidle
In-Reply-To: <52A5E135.2020500@linux.vnet.ibm.com>
References: <52A5C846.30308@linaro.org> <52A5E135.2020500@linux.vnet.ibm.com>
Message-ID: <52A6AFD1.4010002@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/2013 11:26 PM, Preeti U Murthy wrote:
>> > If the cpu stopped the interrupt during deep c-state and without
>> > monitor/mwait support, which kind of ipi can wake the cpu? I mean like a
>> > x86 cpu, APIC stopped in c3 mode, but actually ipi send via apic bus. So
>> > I don't know which ipi work?
>> > 
> As far as my understanding goes, an external interrupt sent via the apic
> bus wakes up a core in deep idle state first,

Is there some evidence for this? Documents or some explanation?
 meaning powers on the core
> and hence the local apic. It does not yet acknowledge the interrupt,
> meaning it cannot invoke the interrupt handler immediately.
>    After the core goes through some initialization steps after wakeup,
> it will be in a position to acknowledge the external interrupt and
> service it accordingly.
> 
> Ideally the interrupt handler of this external interrupt should be that
> of the local timer itself since it was meant to act on the behalf of the
> local timer interrupt.
> 

Added more Intel experts.

Many thanks for response, Preeti!

But I still don't know how to get external/internal interrupt by a deep
c-state cpu.
In Intel Architecture Software Developer's Manual Vol.3A, Figure 10-3.
Local APICs and I/O APIC When P6 Family Processors Are Used in
Multiple-Processor Systems.
The Local APIC is response for the the external/internal interrupt
receiving. and It is included in CPU.

And some explanation often be used in wikipedia.
(http://www.hardwaresecrets.com/article/Everything-You-Need-to-Know-About-the-CPU-C-States-Power-Saving-Modes/611/4)
It said the APIC clock was stopped in deep c-state, So I am wondering
how can the nonfunctional LAPIC pass interrupt to CPU?

And for monitor/mwait idle method, seems deep c-state cpu need to keep a
eye on memory bus. So seems the memory controller in cpu package is
impossible to get into sleep, right?
-- 
Thanks
    Alex
