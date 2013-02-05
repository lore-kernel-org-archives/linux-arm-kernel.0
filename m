From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 05 Feb 2013 12:45:35 +0000
Subject: [PATCH V2] mxs: spi: clear XFER_COUNT in ctrl0 field in DMA
 descriptor
In-Reply-To: <1356500931-31861-1-git-send-email-juha.lumme@gmail.com>
References: <1356500931-31861-1-git-send-email-juha.lumme@gmail.com>
Message-ID: <20130205124535.D59043E0E27@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Dec 2012 14:48:51 +0900, Juha Lumme <juha.lumme@gmail.com> wrote:
> On MX23 the XFER_COUNT part in ctrl0 field in DMA descriptor was improperly
> OR'd during the construction of DMA descriptor chain, instead of being
> freshly set.
> Because of that too many bytes were being expected from SPI during the last
> DMA cycle.
> This caused a timeout (SSP_TIMEOUT) to happen in the processing of the last
> DMA descriptor, and thus reads and writes were failing.
> This is a fix for the problem, by clearing XFER_COUNT bytes in ctrl0 before
> setting the new XFER_COUNT for DMA descriptor.
> 
> Cc: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>

Applied, thanks.

g.
