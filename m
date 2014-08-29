From: geoff@infradead.org (Geoff Levand)
Date: Fri, 29 Aug 2014 14:53:55 -0700
Subject: [PATCH 5/9] arm64: Fix include header order in vmlinux.lds.S
In-Reply-To: <20140827082420.GC6968@arm.com>
References: <cover.1408736066.git.geoff@infradead.org>
 <314ef77423f90ed407b54b4658ea41a96b6f6170.1408736066.git.geoff@infradead.org>
 <20140826162759.GG4078@leverpostej> <1409081250.11425.32.camel@smoke>
 <20140827082420.GC6968@arm.com>
Message-ID: <1409349235.21254.103.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Wed, 2014-08-27 at 09:24 +0100, Catalin Marinas wrote:
> On Tue, Aug 26, 2014 at 08:27:30PM +0100, Geoff Levand wrote:
> > On Tue, 2014-08-26 at 17:27 +0100, Mark Rutland wrote:
> > > On Fri, Aug 22, 2014 at 08:49:16PM +0100, Geoff Levand wrote:
> > > > asm-generic/vmlinux.lds.h should be included after the arch
> > > > specific headers so that the arch headers can override the
> > > > generic macro defs in asm-generic/vmlinux.lds.h.
> > > > 
> > > > Fixes preprosessor redefined warnings when adding arch specific
> > > > macros.
> > > 
> > > A sample of those warnings would be nice. What do you see being
> > > redefined?
> > 
> > In testing I wanted to set LOAD_OFFSET.  If gave warnings like
> > these:
> > 
> >   arch/arm64/include/asm/page.h: warning: "LOAD_OFFSET" redefined [enabled by default]
> > 
> > I'll send out another patch with updated message.
> 
> We currently don't define LOAD_OFFSET, so it would be good to see
> what/why it is defined to. You could keep this patch as part of the
> series introducing LOAD_OFFSET.

Sorry I wasn't clear on this, but I have no plan to define an arm64
specific LOAD_OFFSET.  This patch was intended to add consistency
to the output section definitions in the arm64 linker script, and to
also make the output section definitions in the arm64 linker script
consistent with the way other architectures have their output sections
defined.

If this is not enough motivation for you to be interested in this,
then I won't bother to send out that updated patch.  Please let me
know.

-Geoff
