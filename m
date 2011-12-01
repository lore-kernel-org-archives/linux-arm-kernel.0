From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Thu, 1 Dec 2011 13:02:28 +0100
Subject: [PATCH v2] IMX/SDMA : save the real count for one DMA transaction.
In-Reply-To: <1322705583-18621-1-git-send-email-b32955@freescale.com>
References: <1322705583-18621-1-git-send-email-b32955@freescale.com>
Message-ID: <20183.27860.82295.661892@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Huang Shijie writes:
> When we use the SDMA in the UART driver(such as imx6q), we will
> meet one situation:
>   Assume we set 64 bytes for the RX DMA buffer.
>   The receiving DMA buffer has received some data, but not full.
>   An Aging DMA request will be received by the SDMA controller if we enable the
>   IDDMAEN(UCR4[6]) in this case.
> 
> So the UART driver needs to know the count of the real received bytes,
> and push them to upper layer.
> 
> Add two new fields to sdmac, and update the `residue` in sdma_tx_status().
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  drivers/dma/imx-sdma.c |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index f993955..05ba3a8 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -268,6 +268,7 @@ struct sdma_channel {
>  	struct dma_async_tx_descriptor	desc;
>  	dma_cookie_t			last_completed;
>  	enum dma_status			status;
> +	unsigned int			chn_count, chn_real_count;
>
It would be clearer and more maintenance friendly to have each struct
member definition on a separate line.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
