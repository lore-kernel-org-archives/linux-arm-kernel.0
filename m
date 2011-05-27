From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Fri, 27 May 2011 13:14:11 +0100 (BST)
Subject: [PATCH] ARM: Do not allow unaligned accesses when
	CONFIG_ALIGNMENT_TRAP
In-Reply-To: <mailman.254.1306496353.1533.linux-arm-kernel@lists.infradead.org>
References: <mailman.254.1306496353.1533.linux-arm-kernel@lists.infradead.org>
Message-ID: <alpine.DEB.2.00.1105271304250.13602@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ ... ]
> Subject: Re: [PATCH] ARM: Do not allow unaligned accesses when
> 	CONFIG_ALIGNMENT_TRAP
> Message-ID: <1306490709.26257.4.camel@e102144-lin.cambridge.arm.com>
> Content-Type: text/plain; charset="UTF-8"
>
> Hi Andi,
>
> On Thu, 2011-05-26 at 22:10 +0100, Andi Kleen wrote:
>>
>>> It is possible that -fconserve-stack is still valuable on ARM given that
>>> it is also used with -mno-unaligned-access for other things than
>>> structure packing on the stack, and therefore its merits can be debated
>>> independently from the alignment issue at hand.
>>
>> The big advantage of -fconserve-stack is that it throttles the inliner
>> if the inlining
>> would cause too much stack growth. This is something you likely want
>> on ARM too, especially as code gets more and more complex.
>
> Do you have any concrete examples of -fconserve-stack giving an overall
> win that isn't in the noise? The fact that the GCC documentation
> explicitly states that enabling the option can lead to `making the
> program slower' does make me question why we're enabling it in the first
> place.
>
>> From private conversation, the GCC guys don't seem to think this is a
> bug so I'm reluctant to open a bugzilla ticket.
>
> Will

Isn't this again one of those orthogonalities ? If what is desirable is to 
curb the inlining, then achieving that as one but not the only side effect 
of limiting stack space usage is kind of missing the point.

The GCC manual says -finline-limit does this based on function size; 
haven't experimented, though.

FrankH.
