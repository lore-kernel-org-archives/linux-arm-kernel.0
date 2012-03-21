From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 21 Mar 2012 12:12:11 -0500
Subject: [PATCH] ep93xx: Implement double buffering for M2M DMA channels
In-Reply-To: <4F683B36.8090101@metasoft.pl>
References: <4F683B36.8090101@metasoft.pl>
Message-ID: <ADE657CA350FB648AAC2C43247A983F0020696D488E3@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, March 20, 2012 1:09 AM, Rafal Prylowski wrote:
>
> Implement double buffering for M2M DMA channels.
>
> Signed-off-by: Rafal Prylowski <prylowski@metasoft.pl>

Hmm... This isn't working on my ep9307 board...

When the system boots I get stormed with messages:

dma dma1chan0: unknown interrupt!
dma dma1chan0: unknown interrupt!
dma dma1chan0: unknown interrupt!
dma dma1chan1: unknown interrupt!
dma dma1chan1: unknown interrupt!
dma dma1chan1: unknown interrupt!
dma dma1chan0: unknown interrupt!
dma dma1chan0: unknown interrupt!
dma dma1chan1: unknown interrupt!

Note, I have use_dma set for the ep93xx_spi driver and am using mmc_spi.

Also note, without your patch I also get a couple messages:

dma dma1chan1: got interrupt while active list is empty

But, the mmc card is working fine. I haven't tracked down why I get these
yet. Mika, any ideas?

Regards,
Hartley
