From: ak@linux.intel.com (Andi Kleen)
Date: Thu, 26 May 2011 14:10:24 -0700
Subject: [PATCH] ARM: Do not allow unaligned accesses when
	CONFIG_ALIGNMENT_TRAP
In-Reply-To: <alpine.LFD.2.00.1105261650330.3207@xanadu.home>
References: <20110523111648.10474.78396.stgit@e102109-lin.cambridge.arm.com>
	<20110523132124.GI17672@n2100.arm.linux.org.uk>
	<1306229953.19557.14.camel@e102109-lin.cambridge.arm.com>
	<yw1xipt0p4i9.fsf@unicorn.mansr.com>
	<BANLkTi=xLE9gP5YOdr9dR0DfsY1Ymzxu+w@mail.gmail.com>
	<20110524171331.GA2941@arm.com>
	<20110525111405.GA12010@e102109-lin.cambridge.arm.com>
	<20110525124348.GA2340@arm.com>
	<yw1xaaeanbxe.fsf@unicorn.mansr.com>
	<BANLkTim2TOZgB-3Vkv5RcK572Qr07s3=CA@mail.gmail.com>
	<1306429854.26735.9.camel@e102144-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1105261650330.3207@xanadu.home>
Message-ID: <4DDEC1C0.20807@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> It is possible that -fconserve-stack is still valuable on ARM given that
> it is also used with -mno-unaligned-access for other things than
> structure packing on the stack, and therefore its merits can be debated
> independently from the alignment issue at hand.

The big advantage of -fconserve-stack is that it throttles the inliner 
if the inlining
would cause too much stack growth. This is something you likely want
on ARM too, especially as code gets more and more complex.

-Andi
