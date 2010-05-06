From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 06 May 2010 15:07:11 +0100
Subject: arm926_dma_flush_range undefined!
In-Reply-To: <4BE2C013.4040009@atmel.com>
References: <4BE2C013.4040009@atmel.com>
Message-ID: <1273154831.2094.11.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-05-06 at 15:11 +0200, Nicolas Ferre wrote:
> I am trying to compile a recent kernel 
> (v2.6.34-rc6-201-g722154e) and I am 
> having this kind of error:
> 
> ERROR: "arm926_dma_flush_range" [drivers/mmc/host/at91_mci.ko] undefined!

The driver seems to use dmac_flush_range() directly. That's not part of
the DMA API. Could you not use one of the supported DMA API functions?

-- 
Catalin
