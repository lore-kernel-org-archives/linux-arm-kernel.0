From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Feb 2015 14:28:33 +0000
Subject: [PATCH 5/6] dmaengine: omap-dma: Remove mapping between virtual
 channels and requests
In-Reply-To: <1424787683-19151-6-git-send-email-peter.ujfalusi@ti.com>
References: <1424787683-19151-1-git-send-email-peter.ujfalusi@ti.com>
 <1424787683-19151-6-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20150224142833.GI8670@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 24, 2015 at 04:21:22PM +0200, Peter Ujfalusi wrote:
> Do not direct map the virtual channels to sDMA request number. When the
> sDMA is behind of a crossbar this direct mapping can cause situations when
> certain channel can not be requested since the crossbar request number
> will no longer match with the sDMA request line.
> The direct mapping for virtual channels with HW request lines will make it
> harder to implement MEM_TO_MEM mode for the driver.

I assume when you talk about MEM_TO_MEM, you're referring to a DMA_MEMCPY
driver.

mem2mem should not be handled by the slave driver.  This should be a
separate DMA engine driver structure which does not have DMA_SLAVE set.

See how amba-pl08x handles this.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
