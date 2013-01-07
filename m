From: marex@denx.de (Marek Vasut)
Date: Mon, 7 Jan 2013 13:13:04 +0100
Subject: [PATCH V2] mxs: spi: clear XFER_COUNT in ctrl0 field in DMA
 descriptor
In-Reply-To: <1356500931-31861-1-git-send-email-juha.lumme@gmail.com>
References: <1356500931-31861-1-git-send-email-juha.lumme@gmail.com>
Message-ID: <201301071313.04309.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Juha Lumme,

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
> 
> Signed-off-by: Juha Lumme <juha.lumme@gmail.com>
> Acked-by: Marek Vasut <marex@denx.de>

Bump? This is stable matter too.

Best regards,
Marek Vasut
