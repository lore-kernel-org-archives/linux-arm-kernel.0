From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 30 May 2016 11:17:23 +0200
Subject: [PATCH 4/5] spi: sunxi: set maximum and minimum speed of SPI
 master
In-Reply-To: <7292b1fa08de4f453a643beb63e9faa7826726f6.1464130597.git.hramrach@gmail.com>
References: <cover.1464130597.git.hramrach@gmail.com>
 <7292b1fa08de4f453a643beb63e9faa7826726f6.1464130597.git.hramrach@gmail.com>
Message-ID: <20160530091723.GH4247@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, May 26, 2016 at 07:25:25PM -0000, Michal Suchanek wrote:
> The maximum speed of SPI master is used when maximum speed of SPI slave
> is not specified. Also the __spi_validate function should check that
> transfer speeds do not exceed the master limits.
> 
> The user manual for A10 and A31 specifies maximum
> speed of the SPI clock as 100MHz and minimum as 3kHz.
> 
> Setting the SPI clock to out-of-spec values can lock up the SoC.
> 
> Signed-off-by: Michal Suchanek <hramrach@gmail.com>
> ---
>  drivers/spi/spi-sun4i.c | 2 ++
>  drivers/spi/spi-sun6i.c | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
> index bf52b09..e1a75dd6 100644
> --- a/drivers/spi/spi-sun4i.c
> +++ b/drivers/spi/spi-sun4i.c
> @@ -405,6 +405,8 @@ static int sun4i_spi_probe(struct platform_device *pdev)
>  	}
>  
>  	sspi->master = master;
> +	master->max_speed_hz = 100*1000*1000;

You need spaces around the * operator.

> +	master->min_speed_hz =        3*1000;

And I'm not exactly sure why you have that weird indentation.

The same applies for the sun6i driver

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160530/2d0eafc9/attachment.sig>
