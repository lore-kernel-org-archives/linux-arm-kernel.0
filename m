From: Per.Hallsmark@windriver.com (Hallsmark, Per)
Date: Wed, 31 Aug 2016 10:14:07 +0000
Subject: [PATCH] arm64: ni_syscall should be similar to other archs
In-Reply-To: <20160825110008.GD20748@e104818-lin.cambridge.arm.com>
References: <1456325699-25849-1-git-send-email-per.hallsmark@windriver.com>
 <20160418095808.GB18257@e104818-lin.cambridge.arm.com>
 <B7B4BB465792624BAF51F33077E990659D7C134D@ALA-MBB.corp.ad.wrs.com>,
 <20160825110008.GD20748@e104818-lin.cambridge.arm.com>
Message-ID: <B7B4BB465792624BAF51F33077E99065ACA4BEF7@ALA-MBB.corp.ad.wrs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hmmm... sorry that was completely wrong syscall, sys_membarrier it should have been.


From: Catalin Marinas [catalin.marinas at arm.com]
Sent: Thursday, August 25, 2016 13:00
To: Hallsmark, Per
Cc: Will Deacon; linux-arm-kernel at lists.infradead.org
Subject: Re: [PATCH] arm64: ni_syscall should be similar to other archs

On Thu, Jun 30, 2016 at 01:58:08PM +0000, Hallsmark, Per wrote:
> Catalin Marinas wrote:
> > On Wed, Feb 24, 2016 at 03:54:59PM +0100, per.hallsmark at windriver.com wrote:
> > > From: Per Hallsmark <per.hallsmark@windriver.com>
> > >
> > > Today arm64 have it's own variant when a userspace app is doing a
> > > non-implemented syscall in that it dumps on console process name,
> > > registers and such. This makes a different behaviour on arm64 than
> > > on all other archs.
> >
> > Are you hitting a real issue with this? Test apps doing random syscalls?
>
> The issue was found on a real case, running lttng that tries to make use
> of sys_brk before falling back to internal variant. On arm64 this generates
> an "ugly" dump on console which dont happen on arm, x86 etc.

Why would a sys_brk() end up on the do_ni_syscall() path?

--
Catalin
