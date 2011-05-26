From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 May 2011 22:51:01 +0100
Subject: [PATCH] ARM: Do not allow unaligned accesses when
	CONFIG_ALIGNMENT_TRAP
In-Reply-To: <alpine.LFD.2.00.1105261650330.3207@xanadu.home>
References: <1306229953.19557.14.camel@e102109-lin.cambridge.arm.com>
	<yw1xipt0p4i9.fsf@unicorn.mansr.com>
	<BANLkTi=xLE9gP5YOdr9dR0DfsY1Ymzxu+w@mail.gmail.com>
	<20110524171331.GA2941@arm.com>
	<20110525111405.GA12010@e102109-lin.cambridge.arm.com>
	<20110525124348.GA2340@arm.com>
	<yw1xaaeanbxe.fsf@unicorn.mansr.com>
	<BANLkTim2TOZgB-3Vkv5RcK572Qr07s3=CA@mail.gmail.com>
	<1306429854.26735.9.camel@e102144-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1105261650330.3207@xanadu.home>
Message-ID: <20110526215101.GL24876@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 26, 2011 at 05:03:39PM -0400, Nicolas Pitre wrote:
> It is possible that -fconserve-stack is still valuable on ARM given that 
> it is also used with -mno-unaligned-access for other things than 
> structure packing on the stack, and therefore its merits can be debated 
> independently from the alignment issue at hand.

Catalin said in his mail "I haven't tried with -mno-unaligned-access, I
suspect the variables on the stack would be aligned.".  So I don't think
we know enough to say whether -mno-unaligned-access avoids the stack
packing.
