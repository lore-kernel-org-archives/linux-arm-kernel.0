From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 7 Jul 2011 11:25:28 +0100
Subject: [PATCH v3 01/40] Subject: ARM: mm: proc-macros Add generic
	proc/cache/tlb struct definition macros
In-Reply-To: <20110707101643.GL8286@n2100.arm.linux.org.uk>
References: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
	<1308851448-25139-2-git-send-email-dave.martin@linaro.org>
	<20110707082251.GH8286@n2100.arm.linux.org.uk>
	<20110707100715.GB2486@arm.com>
	<20110707101643.GL8286@n2100.arm.linux.org.uk>
Message-ID: <20110707102528.GF2486@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2011 at 11:16:43AM +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 07, 2011 at 11:07:15AM +0100, Dave Martin wrote:
> > On Thu, Jul 07, 2011 at 09:22:51AM +0100, Russell King - ARM Linux wrote:
> > > If they don't conform to the "<cachename>_<functionname>" pattern then
> > > single-cache model kernels will not compile.
> > 
> > I added this override capability purely because some proc-*.S define multiple
> > sets of cache functions which are mostly common but have some differences.
> > This facility is actually just used by feroceon and xscale, so you're probably
> > right -- it may be better to fix those than encourage deviation elsewhere.
> 
> I think so.
> 
> > For xscale, there is no unconditional MULTI_CACHE, so it looks as though if
> > a single cache model kernel is built, xscale_dma_map_area may get used
> > unconditionally instead of xscale_dma_a0_map_area even for the buggy A0/A1
> > processor revisions.  That won't result in a compile failure, just some
> > incorrect cache maintenance at runtime -- if so, it looks like a bug.
> 
> That sounds like there needs to be a separate patch preceding this series
> which sets MULTI_CACHE unconditionally for Xscale.

OK, I'll submit a separate patch for that.  It's an orthogonal issue really.

> > Do you think we need a generic check for such situations?
> 
> No, I think that would be incredibly hard, and for two processors out of
> the number we already support, I don't think its worth it.

OK -- that was my view too.

I'll rework the series and repost.  The changes shouldn't be invasive.

Cheers
---Dave
