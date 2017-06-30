From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Fri, 30 Jun 2017 14:13:29 +0200
Subject: [PATCH 3/7] serial: imx: init dma_is_{rx|tx}ing variables
In-Reply-To: <20170630120446.13994-4-romain.perier@collabora.com>
References: <20170630120446.13994-1-romain.perier@collabora.com>
 <20170630120446.13994-4-romain.perier@collabora.com>
Message-ID: <20170630141329.6144cddd@karo-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, 30 Jun 2017 14:04:42 +0200 Romain Perier wrote:
> From: Nandor Han <nandor.han@ge.com>
> 
> Initialize both dma_is_{rx|tx}ing variables when DMA is enabled to avoid
> checking uninitialized variables if port shutdown is requested before
> DMA channels get a chance to start.
> 
> Signed-off-by: Nandor Han <nandor.han@ge.com>
> Signed-off-by: Romain Perier <romain.perier@collabora.com>
> ---
>  drivers/tty/serial/imx.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 188063d..81fb413 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1225,6 +1225,9 @@ static void imx_enable_dma(struct imx_port *sport)
>  
>  	imx_setup_ufcr(sport, TXTL_DMA, RXTL_DMA);
>  
> +	sport->dma_is_rxing = 0;
> +	sport->dma_is_txing = 0;
> +
>  	sport->dma_is_enabled = 1;
>  }
>  
sport is devm_kzalloc()ed, so the variables are initialized to 0 anyway.


Lothar Wa?mann
