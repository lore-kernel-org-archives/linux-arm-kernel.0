From: fujita.tomonori@lab.ntt.co.jp (FUJITA Tomonori)
Date: Wed, 3 Mar 2010 15:35:48 +0900
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1267593032.16696.1.camel@pasglop>
References: <1267572594.2173.25.camel@pasglop>
	<20100303124624Z.fujita.tomonori@lab.ntt.co.jp>
	<1267593032.16696.1.camel@pasglop>
Message-ID: <20100303153437E.fujita.tomonori@lab.ntt.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 03 Mar 2010 16:10:32 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Wed, 2010-03-03 at 12:47 +0900, FUJITA Tomonori wrote:
> > The ways to improve the approach (introducing PG_arch_2 or marking a
> > page clean on dma_unmap_* with DMA_FROM_DEVICE like ia64 does) is up
> > to architectures. 
> 
> How does the above work ? IE, the dma unmap will flush the D side but
> not the I side ... or is the ia64 flush primitive magic enough to do
> both ?

On ia64 platform, I (and D) cache is coherent with the memory that you
did DMA to, I think. But better to ask an ia64 guru. :)
