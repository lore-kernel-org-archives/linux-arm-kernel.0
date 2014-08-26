From: geoff@infradead.org (Geoff Levand)
Date: Tue, 26 Aug 2014 12:27:30 -0700
Subject: [PATCH 5/9] arm64: Fix include header order in vmlinux.lds.S
In-Reply-To: <20140826162759.GG4078@leverpostej>
References: <cover.1408736066.git.geoff@infradead.org>
 <314ef77423f90ed407b54b4658ea41a96b6f6170.1408736066.git.geoff@infradead.org>
 <20140826162759.GG4078@leverpostej>
Message-ID: <1409081250.11425.32.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Tue, 2014-08-26 at 17:27 +0100, Mark Rutland wrote:
> On Fri, Aug 22, 2014 at 08:49:16PM +0100, Geoff Levand wrote:
> > asm-generic/vmlinux.lds.h should be included after the arch
> > specific headers so that the arch headers can override the
> > generic macro defs in asm-generic/vmlinux.lds.h.
> > 
> > Fixes preprosessor redefined warnings when adding arch specific
> > macros.
> 
> A sample of those warnings would be nice. What do you see being
> redefined?

In testing I wanted to set LOAD_OFFSET.  If gave warnings like
these:

  arch/arm64/include/asm/page.h: warning: "LOAD_OFFSET" redefined [enabled by default]

I'll send out another patch with updated message.

-Geoff
