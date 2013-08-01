From: davem@davemloft.net (David Miller)
Date: Thu, 01 Aug 2013 14:10:16 -0700 (PDT)
Subject: [PATCH V2 3/3] ethernet: Convert mac address uses of 6 to ETH_ALEN
In-Reply-To: <20130801210618.GK23006@n2100.arm.linux.org.uk>
References: <20130801205817.GJ23006@n2100.arm.linux.org.uk>
 <1375391087.2034.82.camel@joe-AO722>
 <20130801210618.GK23006@n2100.arm.linux.org.uk>
Message-ID: <20130801.141016.1475274289112004539.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Thu, 1 Aug 2013 22:06:18 +0100

> On Thu, Aug 01, 2013 at 02:04:47PM -0700, Joe Perches wrote:
>> On Thu, 2013-08-01 at 21:58 +0100, Russell King - ARM Linux wrote:
>> > This seems rather obscure - I mean, it's not obvious to driver authors
>> > that should be the case.  Would it not be better to make this a little
>> > more obvious somehow?  Maybe __aligned(2) against mac_addr?  Or
>> > maybe have a debugging check for it?
>> 
>> That'd be for David Miller (cc'd).
>> 
>> I believe he's argued in the past that any alignment check
>> for mac addresses was unnecessary.
>> 
>> For all I know it really might not matter because pasemi
>> can successfully dereference a ushort against an odd char
>> pointer.
>> 
>> I just noticed it and thought it'd be better moved.
> 
> As can ARM too for years now - either in hardware or via fixup for
> kernel code.

But probably not a good idea if it's done in a fast path.
