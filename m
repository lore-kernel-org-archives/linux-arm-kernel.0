From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 23 Aug 2012 06:23:33 +0900
Subject: [PATCH] ARM: formalize an IPI for CPU wake-ups
In-Reply-To: <50352D82.2050509@codeaurora.org>
References: <alpine.LFD.2.02.1206111152190.23555@xanadu.home>
 <20120611155716.GA18267@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1206111241470.23555@xanadu.home>
 <20120611165115.GB18267@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1206111307550.23555@xanadu.home>
 <4FD62DBB.8070407@codeaurora.org>
 <20120611192519.GF18267@n2100.arm.linux.org.uk>
 <4FE1FB15.3090305@codeaurora.org>
 <0e0201cd5f2f$2c2f6e60$848e4b20$%kim@samsung.com>
 <5016D03D.8010607@codeaurora.org>
 <CANqRtoQ9BCPhQPi38vK__61G2yAY=g9s17NG3LhSnrxdOYnkDg@mail.gmail.com>
 <50297B34.5090504@codeaurora.org> <50352D82.2050509@codeaurora.org>
Message-ID: <CANqRtoTi_4Te-Nvbj6eq6Jwj4UJ4OTdA9e+H_qtOAToZVmLL+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 23, 2012 at 4:05 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 08/13/12 15:09, Stephen Boyd wrote:
>> On 08/07/12 23:52, Magnus Damm wrote:
>>> So I finally managed to try this out on my KZM9D board. The SMP bring
>>> up code continues to work as expected, so it seems that SGI0 can be
>>> used instead of SGI1 on EMEV2. Let's just say that the boot protocol
>>> implemented by the mask ROM is rather poorly documented. Anyway, to
>>> test I used the following patch on top of linux git 42a579a.
>>>
>>> --- 0001/arch/arm/mach-shmobile/smp-emev2.c
>>> +++ work/arch/arm/mach-shmobile/smp-emev2.c  2012-08-08 15:42:54.000000000 +0900
>>> @@ -82,7 +82,7 @@ int __cpuinit emev2_boot_secondary(unsig
>>>      /* Tell ROM loader about our vector (in headsmp.S) */
>>>      emev2_set_boot_vector(__pa(shmobile_secondary_vector));
>>>
>>> -    gic_raise_softirq(cpumask_of(cpu), 1);
>>> +    gic_raise_softirq(cpumask_of(cpu), 0);
>>>      return 0;
>>>  }
>>>
>>> So if/where needed, please add my:
>>>
>>> Acked-by: Magnus Damm <damm@opensource.se>
>>>
>> Thanks Magnus, would you be able to merge this through the shmobile
>> tree? Otherwise I can put it in the patch tracker.
>>
>
> Ok, I've put it in the patch tracker.

Oh, thanks a lot! We're currently in the middle of rearranging our
kernel repository handling so things move a bit slower than usual...

Thanks for your help!

/ magnus
