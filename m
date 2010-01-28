From: jamie@shareable.org (Jamie Lokier)
Date: Thu, 28 Jan 2010 18:33:03 +0000
Subject: [PATCH 3/3] ARM: Select CPU_32v6K for CPU_V7 only if ARCH_OMAP2
	isnot selected
In-Reply-To: <1264701931.7064.98.camel@pc1117.cambridge.arm.com>
References: <20100126193748.15134.4837.stgit@baageli.muru.com>
	<1264676451.7064.40.camel@pc1117.cambridge.arm.com>
	<20100128174741.GN23505@atomide.com>
	<1264701931.7064.98.camel@pc1117.cambridge.arm.com>
Message-ID: <20100128183303.GA30029@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas wrote:
> > Hmm, but then we can't compile in SMP for single core systems and
> > keep it bootable on single core v6?
> 
> Not with the current kernel since it hardcodes the shareability bit in
> the page tables and the LDREX/STREX operations don't work as expected on
> uniprocessor hardware.

My understanding of LDREX/STREX is that it's allowed to be quite
different on uniprocessors (and CPU-local activity on SMP), but if
it's used properly it still works ok.

Can you say a bit more about assumptions made by the kernel using
LDREX/STREX that fail on uniprocessor hardware?

Is it just the shareability bit in page tables having the wrong value?

Thanks,
-- Jamie
