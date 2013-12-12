From: shijie8@gmail.com (Huang Shijie)
Date: Thu, 12 Dec 2013 12:14:27 +0800
Subject: [PATCH V2 0/4] mtd: spi-nor: add a new framework for SPI NOR
In-Reply-To: <52A881CF.4020001@ti.com>
References: <1386318764-15882-1-git-send-email-b32955@freescale.com>
 <52A881CF.4020001@ti.com>
Message-ID: <20131212041425.GA1460@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 08:46:31PM +0530, Sourav Poddar wrote:
> As you see in my patches, once we take care of the above points and
> add support
> for memory mapped in m25p80 and qspi, then while doing a read in
> m25p80 we can
> do memcpy at the beginning of m25p80_read and can bypass the entire SPI
> framework for memory mapped read operation. Throughput almost gets
> doubles with this,
> as compared to normal SPI operations.
> 
> So, my intention of reviving this here is to add one more feature
> set, which I suppose
> spi nor framework should handle and to see what needs to be added
> more for this feature.

I already read your patch.

My quadspi driver also uses the memory map mode.
The memory map mode is the default mode for the quadspi driver's read.


You can setup the registers for memory map in the probe() or some other
places.  And use the spi_nor->read() hook to do the memcpy in your driver.


thanks
Huang Shijie
