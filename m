From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Tue, 23 Oct 2018 11:49:00 +0200
Subject: [PATCH v3 2/7] spi: spi-mem: add support for octo mode I/O data
 transfer
In-Reply-To: <1540287311-1572-3-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1540287311-1572-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1540287311-1572-3-git-send-email-yogeshnarayan.gaur@nxp.com>
Message-ID: <20181023114900.2ff4cbfc@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Oct 2018 09:37:13 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Add support for octo mode I/O data transfer in spi-mem framework.
> 
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
> Changes for v3:
> - Modified string 'octal' with 'octo'.
> Changes for v2:
> - Patch added in v2 version.
> 
>  drivers/spi/spi-mem.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index c6bdea7..2379efc 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -12,7 +12,7 @@
>  
>  #include "internals.h"
>  
> -#define SPI_MEM_MAX_BUSWIDTH		4
> +#define SPI_MEM_MAX_BUSWIDTH		8
>  
>  /**
>   * spi_controller_dma_map_mem_op_data() - DMA-map the buffer attached to a
> @@ -121,6 +121,13 @@ static int spi_check_buswidth_req(struct spi_mem *mem, u8 buswidth, bool tx)
>  
>  		break;
>  
> +	case 8:
> +		if ((tx && (mode & SPI_TX_OCTO)) ||
> +		    (!tx && (mode & SPI_RX_OCTO)))
> +			return 0;
> +
> +		break;
> +
>  	default:
>  		break;
>  	}
