From: will.deacon@arm.com (Will Deacon)
Date: Tue, 10 Apr 2012 11:35:43 +0100
Subject: Bug in v7_coherent_kern_range() ?
In-Reply-To: <4F840BDC.5060307@freescale.com>
References: <4F77C9A6.6080601@freescale.com>
 <20120402111240.GG19011@mudshark.cambridge.arm.com>
 <4F7E646D.6000302@freescale.com>
 <20120410092214.GA2620@mudshark.cambridge.arm.com>
 <4F840BDC.5060307@freescale.com>
Message-ID: <20120410103543.GB3349@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2012 at 11:30:52AM +0100, Huang Shijie wrote:
> > On Fri, Apr 06, 2012 at 04:35:09AM +0100, Huang Shijie wrote:
> >>> http://lists.arm.linux.org.uk/lurker/message/20111107.173344.f738392e.en.html
> >> I tested this patch.  It fixed this bug. This bug did not occur any more.
> >> But my system still hung at futex. I think the futex issue is another
> >> bug.(will this patch affect the futex?)
> > If you're on an SMP system, can you check that you have df77abca ("ARM:
> > 7099/1: futex: preserve oldval in SMP __futex_atomic_op") applied?
> >
> 
> already applied.
> thanks.
> 
> The futex codes (/kernel/futex.c and arch/arm/include/asm/futex.h) are 
> the latest.
> I guess there is a bug in the futex code in SMP system.

Ok. Can you please:

(a) Make your test case available somewhere?

(b) Try a more recent mainline kernel (3.3)?

Also - which libc are you using? Some older library implementations
incorrectly use swp for atomicity. If you have swp emulation enabled, this
could cause a lock-up. Do you have CONFIG_SWP_EMULATE=y?

Will
