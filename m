From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 02 Jun 2015 17:37:34 +0300
Subject: [PATCH v3 5/6] i2c: at91: print hardware version
In-Reply-To: <0634557b81f0c255411b2f64d78d570267d53b63.1433250713.git.cyrille.pitchen@atmel.com>
References: <cover.1433250713.git.cyrille.pitchen@atmel.com>
 <0634557b81f0c255411b2f64d78d570267d53b63.1433250713.git.cyrille.pitchen@atmel.com>
Message-ID: <556DBFAE.3030502@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 6/2/2015 4:18 PM, Cyrille Pitchen wrote:

> The probe() function now prints the hardware version of the I2C
> controller.

> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> ---
>   drivers/i2c/busses/i2c-at91.c | 4 ++++
>   1 file changed, 4 insertions(+)

> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index 67b4f15..340ce2e 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
[...]
> @@ -872,6 +874,8 @@ static int at91_twi_probe(struct platform_device *pdev)
>   			return rc;
>   	}
>
> +	dev_info(dev->dev, "version: 0x%x\n", at91_twi_read(dev, AT91_TWI_VER));

    Use "%#x" instead please -- it's shorter.

WBR, Sergei
