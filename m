From: steve.capper@linaro.org (Steve Capper)
Date: Tue, 4 Jun 2013 13:56:12 +0100
Subject: [PATCH v2 0/4] ARM: mm: HugeTLB + THP support.
In-Reply-To: <20130603104010.GA26112@linaro.org>
References: <1369323080-9673-1-git-send-email-steve.capper@linaro.org>
 <20130603104010.GA26112@linaro.org>
Message-ID: <20130604125610.GA16818@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 03, 2013 at 11:40:11AM +0100, Steve Capper wrote:
> On Thu, May 23, 2013 at 04:31:16PM +0100, Steve Capper wrote:
> > The following patches bring both HugeTLB support and Transparent
> > HugePage (THP) support to ARM.
> > 
> > Only long descriptors (LPAE) are supported in this series.
> > 
> > The code has been tested on an Arndale board (Exynos 5250).
> > 
> > This patch set is based on 3.10-rc2.
> > 
> > Major changes since the Patch:
> >  * LPAE code has been separated from non-LPAE code (this series
> >    is the LPAE code).
> >  * PROT_NONE support for HugeTLB and THP has been implemented.
> > 
> > Major changes since the RFC:
> >  * huge pmd sharing removed from the 3-level code as this was
> >    found to be very rarely, if ever?, used. This allowed for some
> >    code simplification.
> > 
> >  * hardware pmd bits for 2-levels of paging are now taken from
> >    mmu.c. Also the mapping code now uses pte/pmd bit helper
> >    functions rather than the custom pre-processor logic.
> > 
> > Cheers,
> > -- 
> > Steve
> > 
> 
> Hello,
> I was wondering if anyone had any further comments on this series?
> 
> Russell,
> Are you happy for these to go into your patch system, or should anything be
> changed?
> 
> Thanks,
> -- 
> Steve 

Just a polite ping on the above.

Are people happy to have this patch set merged?

Thanks,
-- 
Steve
