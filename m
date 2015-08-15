From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 15 Aug 2015 20:55:22 +0100
Subject: [PATCH v4] iio: adc: xilinx-xadc: Push interrupts into hardirq
 context
In-Reply-To: <55CB7558.3090608@linutronix.de>
References: <55C07160.5040907@metafoo.de>
 <1439334049-28671-1-git-send-email-xander.huff@ni.com>
 <55CB6391.7060502@metafoo.de> <55CB7558.3090608@linutronix.de>
Message-ID: <55CF992A.5040505@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/08/15 17:33, Sebastian Andrzej Siewior wrote:
> On 08/12/2015 05:17 PM, Lars-Peter Clausen wrote:
>> On 08/12/2015 01:00 AM, Xander Huff wrote:
>>> Unfortunately, this breaks PREEMPT_RT builds, where a spinlock can sleep,
>>> and is thus not able to be acquired from a hardirq handler. This patch gets
>>> rid of the threaded handler and pushes all interrupt handling into the
>>> hardirq context, and uses request_irq().
>>>
>>> To validate that this change has no impact on RT performance, here are
>>> cyclictest values with no processes running:
>>
>> Looks good, thanks.
>>
>> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> Yes, I'm fine with the rework, too.
Formal Acked-by would be good but I'll take this on the basis of Lars' one
and that the code clearly should work from a read through.

Applied to the togreg branch of iio.git.  Thanks for following through
the various twists of this one. Will initially be pushed out as testing.
Note this has almost certainly (unless Linus announces a delay) missed the
upcoming merge window so will be lined up for the 4.4 one.

Jonathan
> 
> Sebastian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
