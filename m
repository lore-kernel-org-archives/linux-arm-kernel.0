From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 29 Jan 2013 10:41:15 +0800
Subject: [PATCH 2/5] spi: pl022: use generic DMA slave configuration if
 possible
In-Reply-To: <1359410300-26113-3-git-send-email-arnd@arndb.de>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
 <1359410300-26113-1-git-send-email-arnd@arndb.de>
 <1359410300-26113-3-git-send-email-arnd@arndb.de>
Message-ID: <20130129024111.GF4748@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 09:58:17PM +0000, Arnd Bergmann wrote:
> With the new OF DMA binding, it is possible to completely avoid the
> need for platform_data for configuring a DMA channel. In cases where the
> platform has already been converted, calling dma_request_slave_channel
> should get all the necessary information from the device tree.
> 
> Like the patch that converts the dw_dma controller, this is completely
> untested and is looking for someone to try it out.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

I've no ability to test this but it looks good from a code point of view.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130129/bc0b0d67/attachment.sig>
