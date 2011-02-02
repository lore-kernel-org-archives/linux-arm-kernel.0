From: davem@davemloft.net (David Miller)
Date: Wed, 02 Feb 2011 15:23:50 -0800 (PST)
Subject: ARM unaligned MMIO access with attribute((packed))
In-Reply-To: <yw1xei7qm3vy.fsf@unicorn.mansr.com>
References: <20110202163702.GA23240@n2100.arm.linux.org.uk>
	<20110202.133831.193702414.davem@davemloft.net>
	<yw1xei7qm3vy.fsf@unicorn.mansr.com>
Message-ID: <20110202.152350.28800670.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: M?ns Rullg?rd <mans@mansr.com>
Date: Wed, 02 Feb 2011 23:08:01 +0000

> David Miller <davem@davemloft.net> writes:
> 
>> From: Russell King - ARM Linux <linux@arm.linux.org.uk>
>> Date: Wed, 2 Feb 2011 16:37:02 +0000
>>
>>> 1. there's no way to tell GCC that the inline assembly is a load
>>>    instruction and therefore it needs to schedule the following
>>>    instructions appropriately.
>>
>> Just add a dummy '"m" (pointer)' asm input argument to the inline asm
>> statement.  Just make sure "typeof(pointer)" has a size matching the
>> size of the load your are performing.
> 
> That should be "m"(*pointer).

Right, thanks for the correction.

>> But you really need that memory clobber there whether you like it or
>> not, see above.
> 
> I don't know of any device where the side-effects are not explicitly
> indicated by other means in the code triggering them, so it probably
> is safe without the clobber as Russel says.

You're probably right.
