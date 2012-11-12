From: shiraz.hashim@st.com (Shiraz Hashim)
Date: Mon, 12 Nov 2012 12:15:47 +0530
Subject: [PATCH] Set bit 22 in the PL310 (cache controller) AuxCtlr
 register
In-Reply-To: <20121109095400.GC2357@mudshark.cambridge.arm.com>
References: <1352433712-16364-1-git-send-email-shiraz.hashim@st.com>
 <20121109095400.GC2357@mudshark.cambridge.arm.com>
Message-ID: <20121112064547.GN32313@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 09, 2012 at 09:54:01AM +0000, Will Deacon wrote:
> On Fri, Nov 09, 2012 at 04:01:52AM +0000, Shiraz Hashim wrote:
> > From: Catalin Marinas <catalin.marinas@arm.com>
> > 
> > Clearing bit 22 in the PL310 Auxiliary Control register (shared
> > attribute override enable) has the side effect of transforming Normal
> > Shared Non-cacheable reads into Cacheable no-allocate reads.
> > 
> > Coherent DMA buffers in Linux always have a Cacheable alias via the
> > kernel linear mapping and the processor can speculatively load cache
> > lines into the PL310 controller. With bit 22 cleared, Non-cacheable
> > reads would unexpectedly hit such cache lines leading to buffer
> > corruption.
> 
> Is this still the case with recent kernels? I thought the dma-mapping/cma
> work avoided the cacheable alias, but perhaps I'm mistaken.

I haven't used CMA but DMA mappings are still normal memory
non-cacheable.

--
regards
Shiraz
