From: prylowski@metasoft.pl (Rafal Prylowski)
Date: Thu, 22 Mar 2012 11:16:57 +0100
Subject: [PATCH] ep93xx: Implement double buffering for M2M DMA channels
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F0020696D488E3@AUSP01VMBX24.collaborationhost.net>
References: <4F683B36.8090101@metasoft.pl>
 <ADE657CA350FB648AAC2C43247A983F0020696D488E3@AUSP01VMBX24.collaborationhost.net>
Message-ID: <4F6AFC19.9040003@metasoft.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-03-21 18:12, H Hartley Sweeten wrote:
> Hmm... This isn't working on my ep9307 board...
> 
> When the system boots I get stormed with messages:
> 
> dma dma1chan0: unknown interrupt!
> dma dma1chan0: unknown interrupt!
> dma dma1chan0: unknown interrupt!
> dma dma1chan1: unknown interrupt!
> dma dma1chan1: unknown interrupt!
> dma dma1chan1: unknown interrupt!
> dma dma1chan0: unknown interrupt!
> dma dma1chan0: unknown interrupt!
> dma dma1chan1: unknown interrupt!
> 
> Note, I have use_dma set for the ep93xx_spi driver and am using mmc_spi.

Thanks for testing. Unfortunately, I'm unable to test this patch with SPI,
because my hardware uses it only for very simple communication (one byte
commands, I noticed that DMA is not used in this case, even if enabled).

In current mainline I also get these messages:

dma dma1chan0: unknown interrupt!
dma dma1chan1: got interrupt while active list is empty

With my patch applied they happen more often (maybe because NFB interrupt
is enabled), but the system is usable. Changing kernel to 3.2.x or using
hack proposed by Mika makes the problem is gone.
