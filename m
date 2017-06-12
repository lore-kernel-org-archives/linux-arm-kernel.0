From: broonie@kernel.org (Mark Brown)
Date: Mon, 12 Jun 2017 17:38:14 +0100
Subject: [PATCH 1/2] spi: rockchip: add support for "cs-gpios" dts property
In-Reply-To: <CAMuHMdUDjtSNRiBxcBnAMdUEaCZbioPoRE1h=p9=BqHMGmQaEQ@mail.gmail.com>
References: <1497248057-16550-1-git-send-email-jeffy.chen@rock-chips.com>
 <dfe87919-b2cc-37e8-1598-6b3c730ff356@rock-chips.com>
 <CAMuHMdUDjtSNRiBxcBnAMdUEaCZbioPoRE1h=p9=BqHMGmQaEQ@mail.gmail.com>
Message-ID: <20170612163814.rgbvb54hgxsdj6tf@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 12, 2017 at 10:18:06AM +0200, Geert Uytterhoeven wrote:
> On Mon, Jun 12, 2017 at 9:15 AM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> > On 2017/6/12 14:14, Jeffy Chen wrote:

> >>   +static int rockchip_spi_setup(struct spi_device *spi)
> >> +{
> >> +       int ret = 0;
> >> +       unsigned long flags = (spi->mode & SPI_CS_HIGH) ?
> >> +                             GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH;
> >> +       struct rockchip_spi_data *data = spi_get_ctldata(spi);
> >> +
> >> +       if (!gpio_is_valid(spi->cs_gpio))
> >> +               return 0;

> > return -EINVAL?

> Isn't this check meant to fall back to hardware CS if no cs-gpios property
> is present?

I'd expect it to, otherwise the cs-gpios property is actualy mandatory.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170612/2c49f7de/attachment.sig>
