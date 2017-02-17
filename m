From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 17 Feb 2017 17:37:07 +0100
Subject: [PATCH v2 5/6] spi: davinci: do not use DMA if transfer length is
 less than 16
In-Reply-To: <1487327904-28311-6-git-send-email-fisaksen@baylibre.com>
References: <1487327904-28311-1-git-send-email-fisaksen@baylibre.com>
 <1487327904-28311-6-git-send-email-fisaksen@baylibre.com>
Message-ID: <CAK8P3a24HkxrU-6a727RY5JqwQgyf9SpprPXvurSqf1Q_W_AMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2017 at 11:38 AM, Frode Isaksen <fisaksen@baylibre.com> wrote:
> Higher bitrate and lower CPU load if using PIO in this case.
>
> Signed-off-by: Frode Isaksen <fisaksen@baylibre.com>
> ---
>  drivers/spi/spi-davinci.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
> index b69a370..826bff1 100644
> --- a/drivers/spi/spi-davinci.c
> +++ b/drivers/spi/spi-davinci.c
> @@ -110,6 +110,8 @@
>  #define SPIDEF         0x4c
>  #define SPIFMT0                0x50
>
> +#define DMA_MIN_BYTES  16

16 seems low as the cutoff. Have you found this experimentally and
tested that for e.g. 32
bytes there is actually an advantage in using DMA?

    Arnd
