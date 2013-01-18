From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Jan 2013 10:42:45 +0000
Subject: [PATCH v2 2/2] ARM: uncompress debug support for multiplatform
 build
In-Reply-To: <201301180847.50913.arnd@arndb.de>
References: <1358436119-30808-3-git-send-email-shawn.guo@linaro.org>
 <1358477120-19673-1-git-send-email-shawn.guo@linaro.org>
 <201301180847.50913.arnd@arndb.de>
Message-ID: <20130118104245.GB23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 18, 2013 at 08:47:50AM +0000, Arnd Bergmann wrote:
> On Friday 18 January 2013, Shawn Guo wrote:
> > +ENTRY(putc)
> > +       addruart r1, r2, r3
> > +       waituart r3, r1
> > +       senduart r0, r1
> > +       busyuart r3, r1
> > +       mov      pc, lr
> > +ENDPROC(putc)
> 
> Ah, so it actually worked? I was expecting at least some part of
> my code to be wrong ;-) My assembler skills are very much
> lacking and I had not tried it.
> 
> Upon closer inspection, it seems that the CR/LF logic from
> the printascii function is not here, and it probably should be.

No it shouldn't.  The CR/LF handling is already done (so actually
aliasing it to printch in arch/arm/kernel/debug.S will result in
two CRs per LF.
