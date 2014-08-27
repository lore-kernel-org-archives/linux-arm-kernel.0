From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 27 Aug 2014 09:24:21 +0100
Subject: [PATCH 5/9] arm64: Fix include header order in vmlinux.lds.S
In-Reply-To: <1409081250.11425.32.camel@smoke>
References: <cover.1408736066.git.geoff@infradead.org>
 <314ef77423f90ed407b54b4658ea41a96b6f6170.1408736066.git.geoff@infradead.org>
 <20140826162759.GG4078@leverpostej>
 <1409081250.11425.32.camel@smoke>
Message-ID: <20140827082420.GC6968@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 08:27:30PM +0100, Geoff Levand wrote:
> On Tue, 2014-08-26 at 17:27 +0100, Mark Rutland wrote:
> > On Fri, Aug 22, 2014 at 08:49:16PM +0100, Geoff Levand wrote:
> > > asm-generic/vmlinux.lds.h should be included after the arch
> > > specific headers so that the arch headers can override the
> > > generic macro defs in asm-generic/vmlinux.lds.h.
> > > 
> > > Fixes preprosessor redefined warnings when adding arch specific
> > > macros.
> > 
> > A sample of those warnings would be nice. What do you see being
> > redefined?
> 
> In testing I wanted to set LOAD_OFFSET.  If gave warnings like
> these:
> 
>   arch/arm64/include/asm/page.h: warning: "LOAD_OFFSET" redefined [enabled by default]
> 
> I'll send out another patch with updated message.

We currently don't define LOAD_OFFSET, so it would be good to see
what/why it is defined to. You could keep this patch as part of the
series introducing LOAD_OFFSET.

-- 
Catalin
