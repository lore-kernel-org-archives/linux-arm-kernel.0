From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 12 Aug 2015 18:33:28 +0200
Subject: [PATCH v4] iio: adc: xilinx-xadc: Push interrupts into hardirq
 context
In-Reply-To: <55CB6391.7060502@metafoo.de>
References: <55C07160.5040907@metafoo.de>
 <1439334049-28671-1-git-send-email-xander.huff@ni.com>
 <55CB6391.7060502@metafoo.de>
Message-ID: <55CB7558.3090608@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/2015 05:17 PM, Lars-Peter Clausen wrote:
> On 08/12/2015 01:00 AM, Xander Huff wrote:
>> Unfortunately, this breaks PREEMPT_RT builds, where a spinlock can sleep,
>> and is thus not able to be acquired from a hardirq handler. This patch gets
>> rid of the threaded handler and pushes all interrupt handling into the
>> hardirq context, and uses request_irq().
>>
>> To validate that this change has no impact on RT performance, here are
>> cyclictest values with no processes running:
> 
> Looks good, thanks.
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Yes, I'm fine with the rework, too.

Sebastian
