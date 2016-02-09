From: eric@anholt.net (Eric Anholt)
Date: Tue, 09 Feb 2016 15:44:02 -0800
Subject: [PATCH 1/4] spi: bcm2835aux: fix bitmask defines
In-Reply-To: <1455041435-8015-2-git-send-email-stephanolbrich@gmx.de>
References: <1455041435-8015-1-git-send-email-stephanolbrich@gmx.de>
 <1455041435-8015-2-git-send-email-stephanolbrich@gmx.de>
Message-ID: <87lh6t4fgd.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

stephanolbrich at gmx.de writes:

> From: Stephan Olbrich <stephanolbrich@gmx.de>
>
> The bitmasks for txempty and idle interrupts were interchanged.
>
> Signed-off-by: Stephan Olbrich <stephanolbrich@gmx.de>
> ---
>  drivers/spi/spi-bcm2835aux.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
> index 7de6f84..ecc73c0 100644
> --- a/drivers/spi/spi-bcm2835aux.c
> +++ b/drivers/spi/spi-bcm2835aux.c
> @@ -73,8 +73,8 @@
>  
>  /* Bitfields in CNTL1 */
>  #define BCM2835_AUX_SPI_CNTL1_CSHIGH	0x00000700
> -#define BCM2835_AUX_SPI_CNTL1_IDLE	0x00000080
> -#define BCM2835_AUX_SPI_CNTL1_TXEMPTY	0x00000040
> +#define BCM2835_AUX_SPI_CNTL1_TXEMPTY	0x00000080
> +#define BCM2835_AUX_SPI_CNTL1_IDLE	0x00000040
>  #define BCM2835_AUX_SPI_CNTL1_MSBF_IN	0x00000002
>  #define BCM2835_AUX_SPI_CNTL1_KEEP_IN	0x00000001

Confirmed by looking at the hardware.

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160209/d846cff3/attachment.sig>
