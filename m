From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 11 Jul 2018 08:32:48 +0200
Subject: [PATCH v1 2/4] dmaengine: imx-sdma: add check_bd_buswidth() to
 kill the dulicated code
In-Reply-To: <1531239793-11781-3-git-send-email-yibin.gong@nxp.com>
References: <1531239793-11781-1-git-send-email-yibin.gong@nxp.com>
 <1531239793-11781-3-git-send-email-yibin.gong@nxp.com>
Message-ID: <20180711063248.pnulmlj3qtcjpsh5@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 12:23:11AM +0800, Robin Gong wrote:
> Add check_bd_buswidth() to minimize the code size.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  drivers/dma/imx-sdma.c | 64 +++++++++++++++++++++++---------------------------
>  1 file changed, 29 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 27ccabf..ed2267d 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -1326,6 +1326,33 @@ static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
>  	return NULL;
>  }
>  
> +static int check_bd_buswidth(struct sdma_buffer_descriptor *bd,
> +			     struct sdma_channel *sdmac, int count,
> +			     dma_addr_t dma_dst, dma_addr_t dma_src)
> +{

Better name this function set_bd_buswidth. I would assume that a
function named check_foo actually checks something, but doesn't set
anything.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
