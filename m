From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 May 2011 09:54:14 +0100
Subject: [PATCH] ARM: Do not allow unaligned accesses when
	CONFIG_ALIGNMENT_TRAP
In-Reply-To: <20110527083806.GA21100@e102109-lin.cambridge.arm.com>
References: <BANLkTi=xLE9gP5YOdr9dR0DfsY1Ymzxu+w@mail.gmail.com>
	<20110524171331.GA2941@arm.com>
	<20110525111405.GA12010@e102109-lin.cambridge.arm.com>
	<20110525124348.GA2340@arm.com>
	<yw1xaaeanbxe.fsf@unicorn.mansr.com>
	<BANLkTim2TOZgB-3Vkv5RcK572Qr07s3=CA@mail.gmail.com>
	<1306429854.26735.9.camel@e102144-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1105261650330.3207@xanadu.home>
	<20110526215101.GL24876@n2100.arm.linux.org.uk>
	<20110527083806.GA21100@e102109-lin.cambridge.arm.com>
Message-ID: <20110527085414.GP24876@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 27, 2011 at 09:38:08AM +0100, Catalin Marinas wrote:
> OK, I tried this now:
> 
> -fconserve-stack: we get unaligned accesses on the stack because the
> newer versions of gcc turned unaligned accesses on by default.
> 
> -fconserve-stack -mno-unaligned-access: the stack variables are aligned.
> We probably get the benefit of -fconserve-stack as well.
> 
> So as per the initial post in this thread, we could have
> -mno-unaligned-access on ARM always on (when CONFIG_ALIGNMENT_TRAP). As
> Nicolas suggested, we could compile some files with -munaligned-access
> (and maybe -fno-conserve-stack).
> 
> I raised this with the gcc guys so they are looking into it. But it
> really doesn't look like a gcc bug as long as -mno-unaligned-access is
> taken into account.

Ok, we need to check one last thing, and that's what the behaviour is
with -mno-unaligned-access and packed structures (such as the ethernet
header).  If it makes no difference, then I suggest we always build
with -mno-unaligned-access.
