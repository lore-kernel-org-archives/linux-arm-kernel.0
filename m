From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 31 Aug 2018 13:41:06 +0200
Subject: [PATCH 1/7] spi: add slave device size in spi_device struct
In-Reply-To: <1535711404-29528-2-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1535711404-29528-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1535711404-29528-2-git-send-email-yogeshnarayan.gaur@nxp.com>
Message-ID: <CAMuHMdWbqEkARvSuMxSRusCj0yi7GUYTyQouRhOi+iYJq9R-Kg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yogesh,

Thanks for your patch!

On Fri, Aug 31, 2018 at 12:33 PM Yogesh Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> Add 'size' data variable in spi_device struct.
> This is to save the size of the connected slave device.

What is the "size" of an SPI slave device?

> After slave device scan, spi_nor_scan, size being assigned to this
> from MTD layer.

Ah, this is MTD specific?

> SFDP read is being requested before completion of spi_nor_scan()
> routine, thus populate device size before making read request
> to the SPI controller.
>
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>

> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -127,6 +127,7 @@ void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
>   *     for driver coldplugging, and in uevents used for hotplugging
>   * @cs_gpio: gpio number of the chipselect line (optional, -ENOENT when
>   *     not using a GPIO line)
> + * @size: size of the connected slave device

Please document what is the meaning of "size".

>   *
>   * @statistics: statistics for the spi_device
>   *
> @@ -168,6 +169,7 @@ struct spi_device {
>         void                    *controller_data;
>         char                    modalias[SPI_NAME_SIZE];
>         int                     cs_gpio;        /* chip select gpio */
> +       u32                     size;           /* size of slave device */
>
>         /* the statistics */
>         struct spi_statistics   statistics;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
