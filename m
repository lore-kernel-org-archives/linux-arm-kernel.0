From: broonie@kernel.org (Mark Brown)
Date: Mon, 7 Jul 2014 08:16:45 +0100
Subject: [PATCH v2 2/2] spi: add driver for Rockchip RK3xxx SoCs
 integrated SPI
In-Reply-To: <53B9FB1C.7080008@rock-chips.com>
References: <1403582852-9751-1-git-send-email-addy.ke@rock-chips.com>
 <1404176639-3315-1-git-send-email-addy.ke@rock-chips.com>
 <20140704183249.GC14896@sirena.org.uk>
 <53B9FB1C.7080008@rock-chips.com>
Message-ID: <20140707071645.GA30458@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 07, 2014 at 09:42:52AM +0800, addy ke wrote:

> > The driver shouldn't be doing this, if it needs a delay it needs to
> > implement it itself.  delay_usecs can be set by devices if they need a
> > delay between transfers, it should be in addition to the time taken for
> > the transfer to complete.

> > Please send a followup patch fixing this.

> Are the following modifications reasonable?

Yes, that looks sensible.

> >> +static const struct of_device_id rockchip_spi_dt_match[] = {
> >> +	{ .compatible = "rockchip,rk3066-spi", },
> >> +	{ },
> >> +};
> >> +MODULE_DEVICE_TABLE(of, rockchip_spi_dt_match);

> > Your DT binding defined some additional compatible strings, please add
> > those to the driver.

> So which is better to describe DT binding for rockchip spi driver as follow:

> 2. Add "rockchip,rk3066-spi", "rockchip,rk3066-spi", "rockchip,rk3066-spi" for each soc:
> 
> In Documentation/devicetree/bindings/spi/spi-rockchip.txt
> - compatible: should be one of the following.
>     "rockchip,rk3066-spi" for rk3066.
>     "rockchip,rk3188-spi", "rockchip,rk3066-spi" for rk3188.
>     "rockchip,rk3288-spi", "rockchip,rk3066-spi" for rk3288.
> 
> In drivers/spi/spi-rockchip.c
> static const struct of_device_id rockchip_spi_dt_match[] = {
>         { .compatible = "rockchip,rk3066-spi", },
>         { .compatible = "rockchip,rk3188-spi", },
>         { .compatible = "rockchip,rk3288-spi", },
>         { },
> };

This is better - that way if we need to care about the differences then
we already have device trees which have the specific compatible strings
in them.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140707/c06dbf4a/attachment.sig>
