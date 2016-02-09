From: info@lategoodbye.de (Stefan Wahren)
Date: Tue, 9 Feb 2016 20:54:03 +0100
Subject: [PATCH 1/4] spi: bcm2835aux: fix bitmask defines
In-Reply-To: <1455041435-8015-2-git-send-email-stephanolbrich@gmx.de>
References: <1455041435-8015-1-git-send-email-stephanolbrich@gmx.de>
 <1455041435-8015-2-git-send-email-stephanolbrich@gmx.de>
Message-ID: <56BA43DB.7030209@lategoodbye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephan,

Am 09.02.2016 um 19:10 schrieb stephanolbrich at gmx.de:
> From: Stephan Olbrich <stephanolbrich@gmx.de>
>
> The bitmasks for txempty and idle interrupts were interchanged.
>
> Signed-off-by: Stephan Olbrich <stephanolbrich@gmx.de>
> ---
>   drivers/spi/spi-bcm2835aux.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
> index 7de6f84..ecc73c0 100644
> --- a/drivers/spi/spi-bcm2835aux.c
> +++ b/drivers/spi/spi-bcm2835aux.c
> @@ -73,8 +73,8 @@
>
>   /* Bitfields in CNTL1 */
>   #define BCM2835_AUX_SPI_CNTL1_CSHIGH	0x00000700
> -#define BCM2835_AUX_SPI_CNTL1_IDLE	0x00000080
> -#define BCM2835_AUX_SPI_CNTL1_TXEMPTY	0x00000040

according to a comment in this file these values are from 
brcm_usrlib/dag/vmcsx/vcinclude/bcm2708_chip/aux_io.h.

So you want to say that at least these 2 are wrong and you took the 
values from BCM2835-ARM-Peripherals.pdf [1]?

I think it's worth to mention it.

Regards

[1] - 
https://www.raspberrypi.org/wp-content/uploads/2012/02/BCM2835-ARM-Peripherals.pdf

> +#define BCM2835_AUX_SPI_CNTL1_TXEMPTY	0x00000080
> +#define BCM2835_AUX_SPI_CNTL1_IDLE	0x00000040
>   #define BCM2835_AUX_SPI_CNTL1_MSBF_IN	0x00000002
>   #define BCM2835_AUX_SPI_CNTL1_KEEP_IN	0x00000001
>
