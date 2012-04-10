From: ijc@hellion.org.uk (Ian Campbell)
Date: Tue, 10 Apr 2012 11:27:10 +0100
Subject: [PATCH] ARM: kirkwood: add missing kexec.h include
In-Reply-To: <20120410100038.GP24211@n2100.arm.linux.org.uk>
References: <1333715458-13834-1-git-send-email-ijc@hellion.org.uk>
 <4F7EE6AE.4020909@mvista.com>
 <1333717838.12209.83.camel@dagon.hellion.org.uk>
 <20120410100038.GP24211@n2100.arm.linux.org.uk>
Message-ID: <1334053630.12209.180.camel@dagon.hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-04-10 at 11:00 +0100, Russell King - ARM Linux wrote:
> On Fri, Apr 06, 2012 at 02:10:38PM +0100, Ian Campbell wrote:
> > On Fri, 2012-04-06 at 16:50 +0400, Sergei Shtylyov wrote:
> > > On 06.04.2012 16:30, Ian Campbell wrote:
> > > > Fixes build the following error when CONFIG_KEXEC is enabled:
> > > 
> > >     Maybe "the following build error" instead?
> > 
> > Done.
> > 
> > > >    CC      arch/arm/mach-kirkwood/board-dt.o
> > > > arch/arm/mach-kirkwood/board-dt.c: In function 'kirkwood_dt_init':
> > > > arch/arm/mach-kirkwood/board-dt.c:52:2: error: 'kexec_reinit' undeclared (first use in this function)
> > > > arch/arm/mach-kirkwood/board-dt.c:52:2: note: each undeclared identifier is reported only once for each function it appears in
> > > 
> > > > kexec.h also needs string.h.
> > > 
> > >     Why it doesn't include it?
> > 
> > Not sure, but actually I should be using linux/kexec.h not asm/kexec.h
> > anyway which solves the problem too:
> 
> Because you should not be using asm/kexec.h directly but using linux/kexec.h
> instead,

Agreed.

>  which will include it via this path:
> 
> linux/kexec.h -> linux/compat.h -> linux/sem.h -> linux/rcupdate.h
>  -> linux/cpumask.h -> linux/bitmap.h -> linux/string.h
> 
> checkpatch has been nobbled not to complain by default about using asm/%.h
> includes when linux/%.h includes are also present, which is a backwards
> step imho.

Yes, I'm not sure what the point of that test would be if it isn't
complaining about that case...

-- 
Ian Campbell


MS-DOS, you can't live with it, you can live without it.
		-- from Lars Wirzenius' .sig
