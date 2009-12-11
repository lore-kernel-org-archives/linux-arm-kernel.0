From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 11 Dec 2009 10:56:46 +0000
Subject: dma_cache_maint_contiguous should be patched asdma_cache_maint do
In-Reply-To: <20091210163920.GA13210@n2100.arm.linux.org.uk>
References: <SNT109-W4788A2C238168B3B9086CBA78D0@phx.gbl>
	<1260459307.23073.41.camel@pc1117.cambridge.arm.com>
	<20091210163920.GA13210@n2100.arm.linux.org.uk>
Message-ID: <1260529006.3563.9.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2009-12-10 at 16:39 +0000, Russell King - ARM Linux wrote:
> Let's hope that all ARMv7 SMP implementations broadcast the cache
> operations.  

I double-checked with the architecture people and the ARMv7 MP extension
mandates cache maintenance broadcasting in hardware. I'll modify my
ARMv7 lazy cache flushing patch to avoid reading MMFR3 in this case.

-- 
Catalin
