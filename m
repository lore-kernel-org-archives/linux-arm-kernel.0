From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 20 Apr 2011 13:41:35 -0400 (EDT)
Subject: [PATCH] ARM: futex: add SMP futex support when !CPU_USE_DOMAINS
In-Reply-To: <1303313347.11314.4.camel@e102144-lin.cambridge.arm.com>
References: <1302267519-18156-1-git-send-email-will.deacon@arm.com>
	<1303313347.11314.4.camel@e102144-lin.cambridge.arm.com>
Message-ID: <alpine.LFD.2.00.1104201329520.24613@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 Apr 2011, Will Deacon wrote:

> On Fri, 2011-04-08 at 13:58 +0100, Will Deacon wrote:
> > This patch uses the load/store exclusive instructions to add SMP futex
> > support for ARM.
> > 
> > Since the ARM architecture does not provide instructions for
> > unprivileged exclusive memory accesses, we can only provide SMP futexes
> > when CPU domain support is disabled.
> > 
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm/include/asm/futex.h |  137 +++++++++++++++++++++++++++--------------
> >  1 files changed, 90 insertions(+), 47 deletions(-)
> 
> Any comments on this patch? The LTP tests for {get,set}_robust_list seem
> happy enough but any review would be welcome.

I looked at http://article.gmane.org/gmane.linux.ports.arm.kernel/81847 
back then, and one issue I found with that version was the fact that the 
#ifdef condition were wrong (not depending on !CONFIG_CPU_USE_DOMAINS.

Your version looks better though, just by looking at the net amount of 
lines added.


Nicolas
