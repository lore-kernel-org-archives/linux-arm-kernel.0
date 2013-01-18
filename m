From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 18 Jan 2013 19:15:57 +0800
Subject: [PATCH v2 2/2] ARM: uncompress debug support for multiplatform
 build
In-Reply-To: <201301180847.50913.arnd@arndb.de>
References: <1358436119-30808-3-git-send-email-shawn.guo@linaro.org>
 <1358477120-19673-1-git-send-email-shawn.guo@linaro.org>
 <201301180847.50913.arnd@arndb.de>
Message-ID: <20130118111556.GB8706@S2101-09.ap.freescale.net>
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
Yes, it worked.  Actually, I wrote it myself after reading your comment
saying take your code as approximation.  And then I compared my code
with yours and found the only difference is the indent of the last
statement :)

> Upon closer inspection, it seems that the CR/LF logic from
> the printascii function is not here, and it probably should be.
> 
No.  As Russell already pointed out, the current implementation of
putc() is exactly what putstr() expect, with no CR/LF logic.

Shawn
