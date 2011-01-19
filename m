From: will.deacon@arm.com (Will Deacon)
Date: Wed, 19 Jan 2011 15:37:38 -0000
Subject: [RFC][PATCH] ARM: ptrace: remove single-step emulation code
In-Reply-To: <20110119151915.GG31652@n2100.arm.linux.org.uk>
References: <1295449635-4292-1-git-send-email-will.deacon@arm.com>
	<20110119151915.GG31652@n2100.arm.linux.org.uk>
Message-ID: <000501cbb7ee$cdccc680$69665380$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

> On Wed, Jan 19, 2011 at 03:07:15PM +0000, Will Deacon wrote:
> > I'm posting this as an RFC to see if anybody has a good reason to keep this
> > code around. There's also a chance I've missed an opportunity to remove some
> > related code, but I think I found everything. Tested on a Versatile Express,
> > single-stepping in GDB worked fine.
> 
> Have you checked whether strace and ltrace use single stepping?

strace works fine with this patch applied and, looking at the
sources, it doesn't use the SINGLESTEP request. As for ltrace,
it *does* use SINGLESTEP but it can use PTRACE_SYSCALL instead
(indeed, it does this for sparc, ia64 and mips). ltrace doesn't
have code for checking the ptrace return value so I'd say it's
their bug.

Will
