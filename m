From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 4 Jun 2015 00:19:22 +0900
Subject: [PATCH v4 5/6] i2c: at91: print hardware version
In-Reply-To: <03bf4d8906d12a87fee7238764074bc5687972be.1433321260.git.cyrille.pitchen@atmel.com>
References: <cover.1433321260.git.cyrille.pitchen@atmel.com>
 <03bf4d8906d12a87fee7238764074bc5687972be.1433321260.git.cyrille.pitchen@atmel.com>
Message-ID: <20150603151921.GA2873@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 03, 2015 at 11:04:26AM +0200, Cyrille Pitchen wrote:
> The probe() function now prints the hardware version of the I2C
> controller.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>

Kernel has already very much printout, so I don't see the gain in adding
another one. At least, combine it with the other printout we have
already, but I wonder what new information will be in here? We should
know from the compatible binding which version we serve? Is it really
needed? Helpful for the user?

> ---
>  drivers/i2c/busses/i2c-at91.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index 67b4f15..cbe6684 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -85,6 +85,8 @@
>  #define	AT91_TWI_ACR_DATAL(len)	((len) & 0xff)
>  #define	AT91_TWI_ACR_DIR	BIT(8)
>  
> +#define	AT91_TWI_VER		0x00fc	/* Version Register */
> +
>  struct at91_twi_pdata {
>  	unsigned clk_max_div;
>  	unsigned clk_offset;
> @@ -872,6 +874,8 @@ static int at91_twi_probe(struct platform_device *pdev)
>  			return rc;
>  	}
>  
> +	dev_info(dev->dev, "version: %#x\n", at91_twi_read(dev, AT91_TWI_VER));
> +
>  	rc = of_property_read_u32(dev->dev->of_node, "clock-frequency",
>  			&bus_clk_rate);
>  	if (rc)
> -- 
> 1.8.2.2
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150604/ff6d2718/attachment.sig>
