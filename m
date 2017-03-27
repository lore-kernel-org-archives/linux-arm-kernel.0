From: anurupvasu@gmail.com (Anurup M)
Date: Mon, 27 Mar 2017 12:03:24 +0530
Subject: [PATCH v6 08/11] drivers: perf: hisi: use poll method to avoid
 L3C counter overflow
In-Reply-To: <20170324114325.GC22771@leverpostej>
References: <1489127325-112821-1-git-send-email-anurup.m@huawei.com>
 <20170321171605.GB29116@leverpostej> <58D4C006.2010907@gmail.com>
 <20170324114325.GC22771@leverpostej>
Message-ID: <58D8B234.3020004@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 24 March 2017 05:13 PM, Mark Rutland wrote:
>>> How do we ensure that we don't take the interrupt in the middle of a
>>> > >sequence of accesses to the HW?
>> >
>> >The L3 cache and MN PMU does not use the overflow IRQ and it does
>> >not occur here
>> >as the interrupt Mask register is by default masked in hardware.
> I was referring to the timer interrupt which backs the hrtimer.
>
> i.e. how do we guarantee that hisi_hrtimer_callback() is not called
> while we are in the middle of a RMW sequence? Are interrupts disabled
> for all of those seqeunces?

The HW access via djtag read and write are protected by spin_lock_irqsave.

Thanks,
Anurup

> Thanks,
> Mark.
