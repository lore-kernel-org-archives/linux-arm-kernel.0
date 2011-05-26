From: ak@linux.intel.com (Andi Kleen)
Date: Thu, 26 May 2011 15:29:34 -0700
Subject: [PATCH] ARM: Do not allow unaligned accesses
	when	CONFIG_ALIGNMENT_TRAP
In-Reply-To: <20110526215101.GL24876@n2100.arm.linux.org.uk>
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
	<20110526215101.GL24876@n2100.arm.linux.org.uk>
Message-ID: <4DDED44E.9070402@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Catalin said in his mail "I haven't tried with -mno-unaligned-access, I
> suspect the variables on the stack would be aligned.".  So I don't think
> we know enough to say whether -mno-unaligned-access avoids the stack
> packing.

It won't, the arm gcc code just checks flag_conserve_stack.
IMHO it's just a gcc bug. You should report it to 
http://gcc.gnu.org/bugzilla

As a temporary workaround you can disable it in the kernel too, but as soon
as the compiler it's fixed I would recommend considering to reenable it.

-Andi
