From: bill4carson@gmail.com (bill4carson)
Date: Mon, 13 Feb 2012 09:07:56 +0800
Subject: [PATCH] hotplug: eliminate warning "Unknown IPI message 0x1"
In-Reply-To: <20120210095955.GT889@n2100.arm.linux.org.uk>
References: <1328866073-14769-1-git-send-email-bill4carson@gmail.com>
 <1328866073-14769-2-git-send-email-bill4carson@gmail.com>
 <20120210095955.GT889@n2100.arm.linux.org.uk>
Message-ID: <4F38626C.5030607@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2012?02?10? 17:59, Russell King - ARM Linux wrote:
> On Fri, Feb 10, 2012 at 05:27:53PM +0800, Bill Carson wrote:
>> When playing hotplug on vexpress board, a tiny warning pops out.
>>
>> /sys/devices/system/cpu # echo 0>  cpu3/online
>> CPU3: shutdown
>> /sys/devices/system/cpu # echo 1>  cpu3/online
>> CPU3: Booted secondary processor
>> Calibrating delay loop (skipped) already calibrated this CPU
>> CPU3: Unknown IPI message 0x1
>>        ^^^^^^^
>> It's a phony warning caused by handle_IPI as a result of calling
>> gic_raise_softirq(cpumask_of(cpu), 1). Introducing a new ipi_msg_type
>> IPI_WAKEUP_CPU to make this warning go away.
>
> NAK.  I want people to move to SGI0 for this, so that we can have SGI1-N
> as the proper IPIs.  The reason _I_ haven't done this is because it's
> totally unclear whether anyone relies on the current IPI number.
>

Thanks for your explanation, now I understand what's going on here.


-- 
I am a slow learner
but I will keep trying to fight for my dreams!

--bill
