From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 3 Apr 2018 09:06:46 +0200
Subject: [PATCH 14/15] ARM: pxa: change SSP devices allocation
In-Reply-To: <20180402142656.26815-15-robert.jarzmik@free.fr>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
 <20180402142656.26815-15-robert.jarzmik@free.fr>
Message-ID: <CAK8P3a2hYWO2eweg3zpR7iJoqtH4uxJLAxJAno7L96G7nA2HxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 2, 2018 at 4:26 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:

>
> +static struct pxa_ssp_info pxa_ssp_infos[] = {
> +       { .dma_chan_rx_name = "ssp1_rx", .dma_chan_tx_name = "ssp1_tx", },
> +       { .dma_chan_rx_name = "ssp1_rx", .dma_chan_tx_name = "ssp1_tx", },
> +       { .dma_chan_rx_name = "ssp2_rx", .dma_chan_tx_name = "ssp2_tx", },
> +       { .dma_chan_rx_name = "ssp2_rx", .dma_chan_tx_name = "ssp2_tx", },
> +       { .dma_chan_rx_name = "ssp3_rx", .dma_chan_tx_name = "ssp3_tx", },
> +       { .dma_chan_rx_name = "ssp3_rx", .dma_chan_tx_name = "ssp3_tx", },
> +       { .dma_chan_rx_name = "ssp4_rx", .dma_chan_tx_name = "ssp4_tx", },
> +       { .dma_chan_rx_name = "ssp4_rx", .dma_chan_tx_name = "ssp4_tx", },
> +};

This part looks odd to me, you're adding an extra level of indirection to
do two stages of lookups in some form of platform data.

Why can't you just always use "rx" and "tx" as the names here?

(also, I don't see why each line is duplicated, but I'm sure there's
an easy answer for that).

       Arnd
