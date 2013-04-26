From: arjan@linux.intel.com (Arjan van de Ven)
Date: Fri, 26 Apr 2013 08:46:21 -0700
Subject: [RFC PATCH v4 00/14] sched: packing small tasks
In-Reply-To: <CAKfTPtCwdw1mYpWRFbPo9zT=9vFANpJyubh1eX-0vJLqrqizgA@mail.gmail.com>
References: <1366910611-20048-1-git-send-email-vincent.guittot@linaro.org>
 <517A969B.5040606@linux.intel.com>
 <CAKfTPtCwdw1mYpWRFbPo9zT=9vFANpJyubh1eX-0vJLqrqizgA@mail.gmail.com>
Message-ID: <517AA14D.7060202@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>
>>
>> so I got to ask the hard question; what percentage of system level (not just
>> cpu level)
>> power consumption gain can you measure (pick your favorite workload)...
>>
>
> I haven't system level figures for my patches but only for the cpu
> subsystem. If we use the MP3 results in the back of my mail, they show
> an improvement of 37 % (113/178) for the CPU subsystem of the
> platform. If we assume that the CPU subsystem contributes 25% of an
> embedded system power consumption (this can vary across platform
> depending of the use of HW accelerator but it should be a almost fair
> percentage), the patch can impact the power consumption on up to 9%.
>

sadly the math tends to not work quite that easy;
memory takes significantly more power when the system is not idle than when it is idle for example. [*]
so while reducing cpu power by making it run a bit longer (at lower frequency or
slower core or whatever) is a pure win if you only look at the cpu, but it may
(or may not) be a loss when looking at a whole system level.

I've learned the hard way that you cannot just look at the cpu numbers; you must look
at the whole-system power when playing with such tradeoffs.

That does not mean that your patch is not useful; it very well can be, but
without having looked at whole-system power that's a very dangerous conclusion to make.
So.. if you get a chance, I'd love to see data on a whole-system level... even for just one workload
and one system
(playing mp3 sounds like a quite reasonable workload for such things indeed)


[*] I assume that on your ARM systems, memory goes into self refresh during system idle just as it does on x86
