From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 26 May 2011 19:14:47 +0100
Subject: [PATCH] ARM: Do not allow unaligned accesses when
	CONFIG_ALIGNMENT_TRAP
In-Reply-To: <1306429854.26735.9.camel@e102144-lin.cambridge.arm.com> (Will
	Deacon's message of "Thu, 26 May 2011 18:10:54 +0100")
References: <20110523111648.10474.78396.stgit@e102109-lin.cambridge.arm.com>
	<20110523132124.GI17672@n2100.arm.linux.org.uk>
	<1306229953.19557.14.camel@e102109-lin.cambridge.arm.com>
	<yw1xipt0p4i9.fsf@unicorn.mansr.com>
	<BANLkTi=xLE9gP5YOdr9dR0DfsY1Ymzxu+w@mail.gmail.com>
	<20110524171331.GA2941@arm.com>
	<20110525111405.GA12010@e102109-lin.cambridge.arm.com>
	<20110525124348.GA2340@arm.com> <yw1xaaeanbxe.fsf@unicorn.mansr.com>
	<BANLkTim2TOZgB-3Vkv5RcK572Qr07s3=CA@mail.gmail.com>
	<1306429854.26735.9.camel@e102144-lin.cambridge.arm.com>
Message-ID: <yw1xvcwxfhwo.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon <will.deacon@arm.com> writes:

> This issue seems to be caused by passing -fconserve-stack to GCC. This
> was added in 8f7f5c9f ("kbuild: set -fconserve-stack option for gcc
> 4.5") and as you can see from the archive:
>
> http://lkml.org/lkml/2009/9/20/39
>
> it was thought to only have an impact on inlining decisions. Looking at
> the documentation for GCC 4.6:
>
> -fconserve-stack
>           Attempt to minimize stack usage. The compiler will attempt to
> use less stack space, even if that makes the program slower. This option
> implies setting the ?large-stack-frame? parameter to 100 and the
> ?large-stack-frame-growth? parameter to 400.
>
> So it sounds like we might not want to enable this blindly across all
> architectures. Indeed, on ARM, it encourages the compiler to pack
> variables on the stack which leads to the weird and wonderful alignment
> situation that has been encountered in this thread.
>
> Can we remove -fconserve-stack from the top-level Makefile (or at least
> make it conditional by architecture)?

Sounds like a good idea to me.

-- 
M?ns Rullg?rd
mans at mansr.com
