From: will.deacon@arm.com (Will Deacon)
Date: Sun, 21 Jul 2013 22:39:37 +0100
Subject: [PATCH] ARM: perf: Implement perf_arch_fetch_caller_regs
In-Reply-To: <20130720034321.GB9433@mozilla.com>
References: <1373685434-1581-1-git-send-email-jld@mozilla.com>
 <20130715135342.GF10000@mudshark.cambridge.arm.com>
 <20130720034321.GB9433@mozilla.com>
Message-ID: <20130721213937.GB29879@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 20, 2013 at 04:43:21AM +0100, Jed Davis wrote:
> On Mon, Jul 15, 2013 at 02:53:42PM +0100, Will Deacon wrote:
> > > +				     "mov %[_pc],  r15\n\t"		\
> > > +				     "mrs %[_cpsr], cpsr\n\t"		\
> > > +				     : [_cpsr] "=r" (_cpsr),		\
> > > +				       [_pc] "=r" (_pc)			\
> > > +				     : [_regs] "r" (&(regs)->uregs)	\
> > 
> > It would be cleaner to pass a separate argument for each register, using the
> > ARM_rN macros rather than calculating the offset by hand.
> 
> I'll do that.  If there were more arguments there might be a problem
> at -O0, because the naive translation can run out of registers in
> some cases, but that shouldn't be a problem here.  (Nor if someone
> later extends this to all the core registers, because {r0-r13} can and
> presumably should use a store-multiple.)

We already rely on compiler optimisation for things like tlbflush.h, so we
don't need to worry about building with -O0.

Please send a v2 when you get a chance!

Will
