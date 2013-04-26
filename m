From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Apr 2013 10:44:30 +0100
Subject: [PATCH 6/9] crypto: ux500/cryp - Set DMA configuration though
 dma_slave_config()
In-Reply-To: <1457204.tIrKjcEogd@wuerfel>
References: <1366280825-31136-1-git-send-email-lee.jones@linaro.org>
 <CACRpkdaBf++gy3sghC-t33uio2+eHp1MrQ2FM0XXBazZTtm3kA@mail.gmail.com>
 <20130426081646.GD24632@intel.com> <1457204.tIrKjcEogd@wuerfel>
Message-ID: <20130426094430.GH14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 26, 2013 at 11:39:20AM +0200, Arnd Bergmann wrote:
> On Friday 26 April 2013 13:46:46 Vinod Koul wrote:
> > 
> > The mapping & unmapping of dma buffer (memcpy and memory buffer in this txn) is
> > required to be performed by the client driver. The dmanegine or dmaengine driver
> > will not do that for you...
> 
> I've been wondering about this part: since we need to pass the 'struct device' of
> the dma engine (rather than the slave) into dma_map_single, what is the official
> way to do that? Should the slave driver just rely on dma_chan->device->dev to
> work correctly for the purpose of dma-mapping.h interfaces?

Yes.
