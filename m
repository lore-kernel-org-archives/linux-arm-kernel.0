From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 24 Jun 2011 11:10:54 +0100
Subject: [PATCH v3 00/40] ARM: mm: Add generic macros for declaring
	various CPU structs
In-Reply-To: <alpine.LFD.2.00.1106231721270.2142@xanadu.home>
References: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
	<alpine.LFD.2.00.1106231721270.2142@xanadu.home>
Message-ID: <20110624101054.GA2342@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 23, 2011 at 07:44:44PM -0400, Nicolas Pitre wrote:
> On Thu, 23 Jun 2011, Dave Martin wrote:
> 
> > General notes:
> > 
> >   - This patch supersedes Peter Chubb's patch for the typo in
> >     proc-arm7tdmi.S (see
> > http://lists.arm.linux.org.uk/lurker/message/20110530.235513.4e1a0d16.en.html),
> > which I believe hasn't been merged.  If it has merged or is
> > pending, I can easily rebase on top of it.
> 
> See commit 9a819d8ac8 in mainline (v3.0-rc2).

Hmmm, I don't see this in -rc3, but it is in -rc4.  I'll rebase.

> 
> >   - This series introduces a few lines slightly longer than 80
> >     characters.  I don't think that splitting these lines will
> >     do a lot to help readability, but this can be done if
> >     people prefer.
> 
> Please don't.

You mean "don't split", right?  (Not "don't introduce"?)

The most heinous cases are already split in any case.

> 
> > 4       proc-mohawk: missing mohawk_flush_icache_all now
> >         referenced and needs to be defined to un-break this file
> >         ** needs review **
> 
> mohawk_flush_icache_all:
> 	mov	r0, #0
> 	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
> 	mov	pc, lr
> 
> The "mov r0, #0" is probably unnecessary, but this is a common pattern.

Thanks, merged locally.

OK if I add your S-o-B to that patch?

> 
> > 5       proc-xscale: missing flush_icache_all funtion in
> >         xscale_80200_A0_A1_cache_fns assumed to be the same as for
> >         xscale_cache_fns **needs review**
> 
> ACK.

Thanks for checking that.  It lookes like the same icache_flush_all
should be appropriate for this case, but I thought it best to check.

> 
> > Dave Martin (40):
> >   Subject: ARM: mm: prop-macros Add generic proc/cache/tlb struct
> >     definition macros
> 
> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> >   Subject: ARM: assembler.h: Add string declaration macro
> 
> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Thanks for those.

> 
> >   Subject: ARM: mm: cache-fa: Use the new processor struct macros
> >   Subject: ARM: mm: cache-v3: Use the new processor struct macros
> >   Subject: ARM: mm: cache-v4: Use the new processor struct macros
> > [...]
> 
> Something is wrong in your Git setup.  You have a spurious "Subject: " 
> prefix everywhere.
> 
> >   Subject: ARM: mm: proc-feroceon: Use the new processor struct macros

Hmmm, I had some scripts sqashing this down from a local 106-patch series.
I guess my logic for pasting subject lines into the merged patches went
wrong somewhere.  I was pretty much a zombie by that stage...

Fixed locally now, but to cut down on spam I won't report immediately.

> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> >  40 files changed, 452 insertions(+), 1968 deletions(-)
> 
> Nice work!

Thanks for the review
---Dave
