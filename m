From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 16 Apr 2013 23:13:41 +0800
Subject: [PATCH 1/4] ARM: mmp: add wakeup function for ICU
In-Reply-To: <175CCF5F49938B4D99B2E3EF7F558EBE2D0FB04F2B@SC-VEXCH4.marvell.com>
References: <1365651463-11502-1-git-send-email-zhangwm@marvell.com>
 <1365651463-11502-2-git-send-email-zhangwm@marvell.com>
 <CAN1soZwFJybMUZgxZJyXcDdKXbpQxaVntyZd8oGnQivLF=ZNNA@mail.gmail.com>
 <175CCF5F49938B4D99B2E3EF7F558EBE2D0FB04F2B@SC-VEXCH4.marvell.com>
Message-ID: <CAN1soZxWkXn4CxJEgZFQHc0MY6Arq2UfpvOEhJ5ZrTKOT=rw4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> > From: Haojian Zhuang [mailto:haojian.zhuang at gmail.com]
>> > Sent: 2013?4?13? 20:50
>> > To: Neil Zhang
>> > Cc: Grant Likely; linux-arm-kernel at lists.infradead.org;
>> > linux-kernel at vger.kernel.org; Chao Xie
>> > Subject: Re: [PATCH 1/4] ARM: mmp: add wakeup function for ICU
>> >
>> > On Thu, Apr 11, 2013 at 11:37 AM, Neil Zhang <zhangwm@marvell.com>
>> > wrote:
>> > > From: Chao Xie <chao.xie@marvell.com>
>> > >
>> > > PXA988 will use GIC as its interrupt controller, and ICU is used as
>> > > wakeup logic. When AP subsystem is powered off, GIC will lose its
>> > > context, the PMU will need ICU to wakeup the AP subsystem.
>> > > When ICU works as wakeup logic, there is no need to know
>> > > intc-nr-irqs, change the corresponding code.
>> > >
>> > > Signed-off-by: Chao Xie <chao.xie@marvell.com>
>> > > Signed-off-by: Neil Zhang <zhangwm@marvell.com>
>> > > ---
>> >
>> > Since it's totally different from original ICU irq initialization, I
>> > suggest to create a new entry to handle this kind of wakeup event. And
>> > we could create a new mask/unmask function.
>>
>> Ok, I'll update it.
> Are you OK if use icu_mask_irq_wakeup / icu_unmask_irq_wakeup for the new functions.

Yes, it's ok to me.
