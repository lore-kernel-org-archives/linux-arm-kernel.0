From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 8 Aug 2017 10:20:22 +0900
Subject: [PATCH] irqchip: uniphier-aidet: add UniPhier AIDET irqchip driver
In-Reply-To: <43777e45-c002-95b8-3b15-d57680f320ec@arm.com>
References: <1501758910-3488-1-git-send-email-yamada.masahiro@socionext.com>
 <cae2ec7d-5f57-3e4f-7688-5a1523c66b82@arm.com>
 <CAK7LNAR=t2=6LbmFKUhSD-ttfxVcyOy6Qy=kj7hsFftDFWqmzQ@mail.gmail.com>
 <43777e45-c002-95b8-3b15-d57680f320ec@arm.com>
Message-ID: <CAK7LNASiqYJ6iF35P78PNQwa8GNdTWE+GEbmFdJr8-_2J4Mgfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,


2017-08-07 22:36 GMT+09:00 Marc Zyngier <marc.zyngier@arm.com>:
> On 07/08/17 12:59, Masahiro Yamada wrote:
>> Hi Marc,
>>
>> Thanks for your comments.
>>
>>
>> 2017-08-07 19:43 GMT+09:00 Marc Zyngier <marc.zyngier@arm.com>:
>>> On 03/08/17 12:15, Masahiro Yamada wrote:
>>>> UniPhier SoCs contain AIDET (ARM Interrupt Detector).  This is intended
>>>> to provide additional features that are not covered by GIC.  The main
>>>> purpose is to provide logic inverter to support low level and falling
>>>> edge trigger type for interrupt lines from on-board devices.
>>>>
>>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>


Thanks.  I will send v2 based on your comments.



If possible, could you help me with my GPIO driver?

I implemented a similar IRQ domain hierarchy handling in the driver.

This patch:
http://patchwork.ozlabs.org/patch/797145/


If I am understanding correctly, the IRQ mapping to the parent
must be somehow hard-coded in the .alloc() hook of irq_domain_ops.

I asked a question in the following.
https://lkml.org/lkml/2017/7/6/758


I do not have a solution to get the IRQ info from "interrupts" property,
so I am hard-coding it in the driver.

-- 
Best Regards
Masahiro Yamada
