From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 8 Feb 2018 09:54:38 +0000
Subject: [PATCH] spi: bcm2835aux: use 64-bit arithmetic instead of 32-bit
In-Reply-To: <20180207160002.GA9292@embeddedgus>
References: <20180207160002.GA9292@embeddedgus>
Message-ID: <CAKv+Gu9hmxLSS0ekr8av-ADt3OQjBV=Bt-hRq_-SzWaGODs4SQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 February 2018 at 16:00, Gustavo A. R. Silva <gustavo@embeddedor.com> wrote:
> Add suffix ULL to constant 9 in order to give the compiler complete
> information about the proper arithmetic to use. Notice that this
> constant is used in a context that expects an expression of type
> unsigned long long (64 bits, unsigned).
>
> The expression tfr->len * 9 * 1000000 is currently being evaluated
> using 32-bit arithmetic.
>
> Addresses-Coverity-ID: 1339619

What does this number mean? If it is an index into some internal
database, please remove it.

> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/spi/spi-bcm2835aux.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
> index 7428091..a768c23 100644
> --- a/drivers/spi/spi-bcm2835aux.c
> +++ b/drivers/spi/spi-bcm2835aux.c
> @@ -363,7 +363,7 @@ static int bcm2835aux_spi_transfer_one(struct spi_master *master,
>          * chunk getting transferred - in our case the chunk size
>          * is 3 bytes, so we approximate this by 9 bits/byte
>          */
> -       xfer_time_us = tfr->len * 9 * 1000000;
> +       xfer_time_us = tfr->len * 9ULL * 1000000;
>         do_div(xfer_time_us, spi_used_hz);
>
>         /* run in polling mode for short transfers */
> --
> 2.7.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
