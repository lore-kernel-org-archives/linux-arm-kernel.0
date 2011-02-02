From: davem@davemloft.net (David Miller)
Date: Wed, 02 Feb 2011 13:59:54 -0800 (PST)
Subject: ARM unaligned MMIO access with attribute((packed))
In-Reply-To: <20110202214522.GG31043@n2100.arm.linux.org.uk>
References: <20110202163702.GA23240@n2100.arm.linux.org.uk>
	<20110202.133831.193702414.davem@davemloft.net>
	<20110202214522.GG31043@n2100.arm.linux.org.uk>
Message-ID: <20110202.135954.189712480.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Wed, 2 Feb 2011 21:45:22 +0000

> On Wed, Feb 02, 2011 at 01:38:31PM -0800, David Miller wrote:
>> From: Russell King - ARM Linux <linux@arm.linux.org.uk>
>> Date: Wed, 2 Feb 2011 16:37:02 +0000
>> 
>> > 1. there's no way to tell GCC that the inline assembly is a load
>> >    instruction and therefore it needs to schedule the following
>> >    instructions appropriately.
>> 
>> Just add a dummy '"m" (pointer)' asm input argument to the inline asm
>> statement.  Just make sure "typeof(pointer)" has a size matching the
>> size of the load your are performing.
> 
> That involves this problematical cast from a packed struct pointer to
> an unsigned long pointer, which according to the C standard and GCC
> folk is undefined.

It's alignment may be undefined, but it's size definitely is well
defined and that's what matters here.

> Practice over the last 15 years on ARM has also shown that this is not
> necessary.

Sorry oh big super man, little ole' me is only a kernel newbie.
