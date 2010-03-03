From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 03 Mar 2010 16:10:32 +1100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <20100303124624Z.fujita.tomonori@lab.ntt.co.jp>
References: <20100302211049V.fujita.tomonori@lab.ntt.co.jp>
	<1267549527.15401.78.camel@e102109-lin.cambridge.arm.com>
	<1267572594.2173.25.camel@pasglop>
	<20100303124624Z.fujita.tomonori@lab.ntt.co.jp>
Message-ID: <1267593032.16696.1.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-03-03 at 12:47 +0900, FUJITA Tomonori wrote:
> The ways to improve the approach (introducing PG_arch_2 or marking a
> page clean on dma_unmap_* with DMA_FROM_DEVICE like ia64 does) is up
> to architectures. 

How does the above work ? IE, the dma unmap will flush the D side but
not the I side ... or is the ia64 flush primitive magic enough to do
both ?

Cheers,
Ben.
