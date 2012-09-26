From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Wed, 26 Sep 2012 15:32:59 -0700
Subject: [PATCH 08/11] ARM: Move some macros from entry-armv to
 entry-header
In-Reply-To: <50637C24.90206@codeaurora.org>
References: <20120924212648.GA27605@lizard>
 <1348522080-32629-8-git-send-email-anton.vorontsov@linaro.org>
 <50637C24.90206@codeaurora.org>
Message-ID: <20120926223258.GA5768@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 26, 2012 at 03:05:24PM -0700, Stephen Boyd wrote:
> > Just move the macros into header file as we would want to use them for
> > KGDB FIQ entry code.
> >
> > The following macros were moved:
> >
> >  - svc_entry
> >  - usr_entry
> >  - kuser_cmpxchg_check
> >  - vector_stub
> >
> > To make kuser_cmpxchg_check actually work across different files, we
> > also have to make kuser_cmpxchg64_fixup global.
> >
> > Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
> 
> Why can't we put the fiq entry code from the next patch into
> entry-armv.S? Sorry if this has been asked before but I don't see any
> reasoning in the commit text.

Thanks for taking a look!

This is a prerequisite to just logically separate KGDB FIQ code from the
entry code.

Or to put it the other way around: KGDB FIQ is just another user of the
FIQs, nothing quite special in it to put it alongside the entry code. :-)

But if Russell or other folks feel that having KGDB FIQ asm code in
entry-armv.S makes sense, I'd definitely do this.

Thanks,
Anton.
