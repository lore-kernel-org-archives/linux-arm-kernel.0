From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 25 Jan 2013 13:21:49 +0530
Subject: [PATCH] arm: omap: make wakeupgen_lock raw
In-Reply-To: <20130124182159.GL4424@arwen.pp.htv.fi>
References: <1354891787-24119-1-git-send-email-balbi@ti.com>
 <20130124182159.GL4424@arwen.pp.htv.fi>
Message-ID: <51023995.1050703@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 24 January 2013 11:52 PM, Felipe Balbi wrote:
> Hi,
>
> On Fri, Dec 07, 2012 at 04:49:47PM +0200, Felipe Balbi wrote:
>> From: Thomas Gleixner <tglx@linutronix.de>
>>
>> When applying RT patch on top of Linux, spinlocks are
>> implemented as RT-mutexes, which means they are preemptable.
>>
>> Current GIC implementation on OMAP is using a spinlock
>> to protect against preemption. As it turns out, we need
>> to convert that lock into a raw_spinlock so that OMAP's
>> interrupt controller works as expected after RT-patch
>> is applied.
>>
>> This patch is simply to decrease the amount of changes
>> RT-team needs to carry out of tree. It doesn't cause any
>> changes in behavior.
>>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>
Sorry i missed this patch. Tony can you please
pick it up?

For the patch,
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
