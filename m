From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 Dec 2010 22:59:03 +0000
Subject: dma_cache_sync replacement call
In-Reply-To: <AANLkTi=p3eaVKUNvxLCThhDC534j_SX+TUtxYgGfu40Q@mail.gmail.com>
References: <AANLkTi=p3eaVKUNvxLCThhDC534j_SX+TUtxYgGfu40Q@mail.gmail.com>
Message-ID: <20101215225903.GJ9937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 15, 2010 at 02:54:57PM -0800, y bhanu wrote:
> I am porting a Linux wireless driver from MIPS to ARM (ixp4xx).
> 
> As dma_cache_sync() is not implemented for ARM ,I get some nasty errors:
> I am not sure whats the replacement for this deprecated call under ARM.
> 
> can  anyone help figure out what use instread of dma_cache_sync() &
> dma_cache_wback_inv() calls?

The answer is to complain to MIPS people as to why they are using their
own private DMA cache support rather than the DMA API (whose documentation
can be found in Documentation/DMA-API.txt).

The answer is there is no straight replacement - the answer is to fix the
driver to use the proper portable interfaces.
