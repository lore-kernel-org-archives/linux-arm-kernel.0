From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Feb 2012 20:53:46 +0000
Subject: [PATCH 00/17] SA11x0 cleanups (mainly assabet/neponset)
In-Reply-To: <alpine.LFD.2.02.1202031533030.2759@xanadu.home>
References: <20120203193059.GF14129@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1202031533030.2759@xanadu.home>
Message-ID: <20120203205346.GL14129@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 03, 2012 at 03:43:43PM -0500, Nicolas Pitre wrote:
> I've quickly looked through this series and this all looks sensible.
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>

Thanks.

> My knowledge of the SA1111 chip was never extensive, and the little I 
> had did fade away at this point.  So it might not be relevant for me to 
> give any comment on the other series.  Except that I thought that DMA 
> was terminally broken on that chip, hence I'm surprized to see OHCI 
> support for it.

It is rather badly broken, but the hack to move the kernel 1MB into
SDRAM and dmabounce continues to do their jobs, making it work.

And let's also not forget that the errata documentation was (probably)
one of the worst - I have this comment from years back in the code...

/*
 * Don't believe the specs!  Take them, throw them outside.  Leave them
 * there for a week.  Spit on them.  Walk on them.  Stamp on them.
 * Pour gasoline over them and finally burn them.  Now think about coding.
 *  - The October 1999 errata (278260-007) says its bit 13, 1 to enable.
 *  - The Feb 2001 errata (278260-010) says that the previous errata
 *    (278260-009) is wrong, and its bit actually 12, fixed in spec
 *    278242-003.
 *  - The SA1111 manual (278242) says bit 12, but 0 to enable.
 *  - Reality is bit 13, 1 to enable.
 *      -- rmk
 */
#define SKCR_OE_EN      (1<<13)

In those days, we had specifications on paper!
