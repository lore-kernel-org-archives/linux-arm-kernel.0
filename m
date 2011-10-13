From: colin.tuckley@arm.com (Colin Tuckley)
Date: Thu, 13 Oct 2011 10:09:16 +0100
Subject: [PATCH 1/5 v4] ARM Realview PCIX map include file changes
In-Reply-To: <20111012172007.GA21648@n2100.arm.linux.org.uk>
References: <20111007142310.19554.17204.stgit@e102602-lin.cambridge.arm.com>
	<20111007142723.19554.88566.stgit@e102602-lin.cambridge.arm.com>
	<20111007192224.GB25689@n2100.arm.linux.org.uk>
	<000001cc872e$d1aaf870$7500e950$@tuckley@arm.com>
	<20111012172007.GA21648@n2100.arm.linux.org.uk>
Message-ID: <000001cc8987$c9079790$5b16c6b0$@tuckley@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Subject: Re: [PATCH 1/5 v4] ARM Realview PCIX map include file changes

> On Mon, Oct 10, 2011 at 10:27:08AM +0100, Colin Tuckley wrote:
> > Ah, I wasn't aware of that. However when I include asm/io.h and
> remove the
> 
> The general rule is that linux/io.h includes asm/io.h, which in turn
> includes mach/io.h includes and nothing should include either asm/io.h
> nor mach/io.h directly - if it does, things probably break - which is
> desirable behaviour because that indicates that the include is wrong.

Right sounds very sensible :)

> > A quick check shows that the piece of code you quote above does not
> exist in
> > my (3.1.0-rc9) source tree.
> 
> It's not in -rc9, but will be during the next merge window - and is in
> linux-next.

Ah, understood. Do you have any other concerns about this patch? If not then
I'll submit it to your patch system with the IO_SPACE_LIMIT stuff fixed.

Colin
