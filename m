From: ak@linux.intel.com (Andi Kleen)
Date: Thu, 26 May 2011 12:58:40 -0700
Subject: [PATCH] ARM: Do not allow unaligned accesses when
	CONFIG_ALIGNMENT_TRAP
In-Reply-To: <1306429854.26735.9.camel@e102144-lin.cambridge.arm.com>
References: <20110523111648.10474.78396.stgit@e102109-lin.cambridge.arm.com>	
	<20110523132124.GI17672@n2100.arm.linux.org.uk>	
	<1306229953.19557.14.camel@e102109-lin.cambridge.arm.com>	
	<yw1xipt0p4i9.fsf@unicorn.mansr.com>	
	<BANLkTi=xLE9gP5YOdr9dR0DfsY1Ymzxu+w@mail.gmail.com>	
	<20110524171331.GA2941@arm.com>	
	<20110525111405.GA12010@e102109-lin.cambridge.arm.com>	
	<20110525124348.GA2340@arm.com>	<yw1xaaeanbxe.fsf@unicorn.mansr.com>	
	<BANLkTim2TOZgB-3Vkv5RcK572Qr07s3=CA@mail.gmail.com>
	<1306429854.26735.9.camel@e102144-lin.cambridge.arm.com>
Message-ID: <4DDEB0F0.3010101@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> So it sounds like we might not want to enable this blindly across all
> architectures. Indeed, on ARM, it encourages the compiler to pack
> variables on the stack which leads to the weird and wonderful alignment
> situation that has been encountered in this thread.

Interesting. I'm pretty sure it didn't do that when I added the flag.

Anyways making it a CONFIG is fine for me. Just don't set it on ARM. It 
should be set on x86
at least.

-Andi
