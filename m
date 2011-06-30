From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 30 Jun 2011 12:38:18 +0530
Subject: [PATCH 2/2] SPI: SAMSUNG: Bug fix for SPI with different FIFO
	level
In-Reply-To: <1309437536-9315-2-git-send-email-padma.v@samsung.com>
References: <1309437536-9315-1-git-send-email-padma.v@samsung.com>
	<1309437536-9315-2-git-send-email-padma.v@samsung.com>
Message-ID: <BANLkTi=L7QeN75ebWFXdp_V5Pw1zEc-ZtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 30, 2011 at 6:08 PM, Padmavathi Venna <padma.v@samsung.com> wrote:
> Fixed the bug in transmission status check for 64 bytes FIFO
> level.
>
> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
> ---
> ?drivers/spi/spi_s3c64xx.c | ? ?4 +---
> ?1 files changed, 1 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/spi/spi_s3c64xx.c b/drivers/spi/spi_s3c64xx.c
> index 795828b..8945e20 100644
> --- a/drivers/spi/spi_s3c64xx.c
> +++ b/drivers/spi/spi_s3c64xx.c
> @@ -116,9 +116,7 @@
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?(((i)->fifo_lvl_mask + 1))) \
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?? 1 : 0)
>
> -#define S3C64XX_SPI_ST_TX_DONE(v, i) ((((v) >> (i)->rx_lvl_offset) & \
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? (((i)->fifo_lvl_mask + 1) << 1)) \
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 1 : 0)
> +#define S3C64XX_SPI_ST_TX_DONE(v, i) (((v) & (1 << (i)->tx_st_done)) ? 1 : 0)

IIRC the macro is already designed to deduct tx-done levels from other fields.
Could you please _explain_ with one example where it fails ? It is
difficult to see without
numbers.

Thanks,
-Jassi
