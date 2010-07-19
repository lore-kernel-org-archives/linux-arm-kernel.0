From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 19 Jul 2010 13:29:17 +0100
Subject: Problem with dma_alloc_coherent at linux-2.6.33-arm1 ,
	withRealView platform,board PBX-A9 and armv7 instructions.
In-Reply-To: <AANLkTikiHfOL0WMjiZnWY3RVmw89hZVFcNkqfDUYSDgG@mail.gmail.com>
References: <AANLkTikiHfOL0WMjiZnWY3RVmw89hZVFcNkqfDUYSDgG@mail.gmail.com>
Message-ID: <1279542557.10760.21.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2010-07-17 at 08:05 +0100, David Yang wrote:
> I have a question: in linux-2.6.28, there is no barriers in the IO
> accessors.

Because in 2.6.28 we used Strongly Ordered memory for the coherent DMA
buffers and on many CPUs SO accesses are ordered relatively to Device
accesses. But that even this isn't guaranteed by the ARM ARM.

-- 
Catalin
