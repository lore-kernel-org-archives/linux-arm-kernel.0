From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 19 May 2012 23:03:08 -0600
Subject: [PATCH v2 1/6] spi: s3c64xx: remove unused S3C64XX_SPI_ST_TRLCNTZ
 macro
In-Reply-To: <1337333613-6216-2-git-send-email-thomas.abraham@linaro.org>
References: <1337333613-6216-1-git-send-email-thomas.abraham@linaro.org>
 <1337333613-6216-2-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20120520050309.224ED3E03B8@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 May 2012 15:03:28 +0530, Thomas Abraham <thomas.abraham@linaro.org> wrote:
> The macro S3C64XX_SPI_ST_TRLCNTZ is not used and hence it is removed.
> 
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> Acked-by: Jaswinder Singh <jaswinder.singh@linaro.org>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  drivers/spi/spi-s3c64xx.c |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 972a94c..6a3d51a 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -113,10 +113,6 @@
>  
>  #define S3C64XX_SPI_FBCLK_MSK		(3<<0)
>  
> -#define S3C64XX_SPI_ST_TRLCNTZ(v, i) ((((v) >> (i)->rx_lvl_offset) & \
> -					(((i)->fifo_lvl_mask + 1))) \
> -					? 1 : 0)
> -
>  #define S3C64XX_SPI_ST_TX_DONE(v, i) (((v) & (1 << (i)->tx_st_done)) ? 1 : 0)
>  #define TX_FIFO_LVL(v, i) (((v) >> 6) & (i)->fifo_lvl_mask)
>  #define RX_FIFO_LVL(v, i) (((v) >> (i)->rx_lvl_offset) & (i)->fifo_lvl_mask)
> -- 
> 1.6.6.rc2
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
