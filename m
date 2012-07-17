From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 17 Jul 2012 12:15:23 +0530
Subject: [PATCH 1/1] mmc: host: enable OMAP DMA engine support for omap
 hosts by default
In-Reply-To: <1342485005-5178-1-git-send-email-javier@dowhile0.org>
References: <1342485005-5178-1-git-send-email-javier@dowhile0.org>
Message-ID: <CAMQu2gxaF8K78puE84+=8VJLbsdtdD97ww81XJxG6sCtYTYXww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 17, 2012 at 6:00 AM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:
> The OMAP MMC and OMAP High Speed MMC hosts now use entirely the DMA
> engine API instead of the previous private DMA API implementation.
>
> So, if the kernel is built with support for any of these hosts but it
> doesn't support DMA devices nor OMAP DMA support, it fails when trying
> to obtain a DMA channel which leads to the following error on an OMAP3
> IGEPv2 Rev.C board (and probably on most OMAP boards with MMC support):
>
> [    2.199981] omap_hsmmc omap_hsmmc.1: unable to obtain RX DMA engine channel 48
> [    2.215087] omap_hsmmc omap_hsmmc.0: unable to obtain RX DMA engine channel 62
>
> selecting automatically CONFIG_DMADEVICES and CONFIG_DMA_OMAP solves it.
>
> Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
> ---
Considering, we are updating drivers to select the DMA engine, can you
also include
"drivers/spi/spi-omap2-mcspi.c" which is also updated for DMA engine.

Regards
Santosh
