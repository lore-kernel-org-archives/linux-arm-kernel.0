From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 27 Apr 2012 21:00:22 +0200
Subject: [PATCH 05/12] mmc: omap_hsmmc: add DMA engine support
In-Reply-To: <E1SMLlv-0002WI-8a@rmk-PC.arm.linux.org.uk>
References: <20120423160409.GE24299@n2100.arm.linux.org.uk>
 <E1SMLlv-0002WI-8a@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdZPEnPTpp+vwJed4ZkXLNjEVUz==YVvwg_bhuUOyD3Fxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2012 at 6:05 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> Add DMA engine support to the OMAP HSMMC driver. ?This supplements the
> private DMA API implementation contained within this driver, and the
> driver can be switched at build time between using DMA engine and the
> private DMA API.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Great,

> +#if 1
> + ? ? ? ? ? ? ? sig = host->dma_line_rx;
> + ? ? ? ? ? ? ? host->rx_chan = dma_request_channel(mask, omap_dma_filter_fn, &sig);
> + ? ? ? ? ? ? ? if (!host->rx_chan) {
> + ? ? ? ? ? ? ? ? ? ? ? dev_warn(mmc_dev(host->mmc), "unable to obtain RX DMA engine channel %u\n", sig);
> + ? ? ? ? ? ? ? }
> +#endif
> +#if 1
> + ? ? ? ? ? ? ? sig = host->dma_line_tx;
> + ? ? ? ? ? ? ? host->tx_chan = dma_request_channel(mask, omap_dma_filter_fn, &sig);
> + ? ? ? ? ? ? ? if (!host->tx_chan) {
> + ? ? ? ? ? ? ? ? ? ? ? dev_warn(mmc_dev(host->mmc), "unable to obtain TX DMA engine channel %u\n", sig);
> + ? ? ? ? ? ? ? }
> +#endif

Are these development artifacts?

Apart from that:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
