From: rickard.andersson@stericsson.com (Rickard Andersson)
Date: Mon, 11 Mar 2013 10:28:29 +0100
Subject: [PATCH 0/4] time: dynamic irq affinity
In-Reply-To: <513DA009.9080601@ti.com>
References: <1361917047-29230-1-git-send-email-daniel.lezcano@linaro.org>
 <513CC404.6000200@ti.com> <513CCF60.6060406@linaro.org>
 <513D4E79.5090307@ti.com> <513D9896.2010304@linaro.org>
 <513DA009.9080601@ti.com>
Message-ID: <513DA3BD.4070003@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/2013 10:12 AM, Santosh Shilimkar wrote:
> On Monday 11 March 2013 02:10 PM, Daniel Lezcano wrote:
>> On 03/11/2013 04:24 AM, Santosh Shilimkar wrote:
>>> On Sunday 10 March 2013 11:52 PM, Daniel Lezcano wrote:
>> [ ... ]
>>
>>>> I don't think it is the case for all the ARM platforms, at least we
>>>> tested it on vexpress TC2 and u8500, and the number of IPI were reduced
>>>> very significantly increasing the idle time for cpu0. TC2 will need
>>>> another optimization on another area for the idle wake up to gain real
>>>> improvements.
>>>>
>>> You are missing my point. TC2 can be an exception since the SGI can wakeup
>>> CPUs even from low power states where local timer's are stalled. Is that
>>> the case with U8500 ?
>> Well, the cpuidle driver is not going into a deep idle state to check
>> this out.
>>
>> AFAICT this board has a specific firmware with the PRCMU (a device
>> managing the power on the board) and it replaces the GIC when going to
>> deep idle state, especially by reconnecting the GIC to the A9 cores
>> automatically when an interrupt occurs.
>>
> But most likely it will be limited to peripheral interrupts. SGI's
> are per-cpu irq's so you need to check that part.
>
In the U8500 case, when the first CPU is woken up it will work ok for 
that CPU to send an IPI to the other CPU.

BR
Rickard
