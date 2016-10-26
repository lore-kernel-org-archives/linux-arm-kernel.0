From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 26 Oct 2016 15:01:52 +0100
Subject: [PATCH] mfd: axp20x-i2c: Add i2c-ids to fix module auto-loading
In-Reply-To: <20161005155112.13774-2-hdegoede@redhat.com>
References: <20161005155112.13774-1-hdegoede@redhat.com>
 <20161005155112.13774-2-hdegoede@redhat.com>
Message-ID: <20161026140152.GF13127@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 05 Oct 2016, Hans de Goede wrote:

> The i2c subsys does not load modules by compatible, only by
> i2c-id, with e.g. a modalias of: "i2c:axp209".
> 
> Populate the axp20x_i2c_id[] table with supported ids, so that
> module auto-loading will work.
> 
> Reported-by: Dennis Gilmore <dennis@ausil.us>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/mfd/axp20x-i2c.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Applied (for now), thanks.

> diff --git a/drivers/mfd/axp20x-i2c.c b/drivers/mfd/axp20x-i2c.c
> index b1b8658..d35a5fe 100644
> --- a/drivers/mfd/axp20x-i2c.c
> +++ b/drivers/mfd/axp20x-i2c.c
> @@ -69,10 +69,11 @@ static const struct of_device_id axp20x_i2c_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, axp20x_i2c_of_match);
>  
> -/*
> - * This is useless for OF-enabled devices, but it is needed by I2C subsystem
> - */
>  static const struct i2c_device_id axp20x_i2c_id[] = {
> +	{ "axp152", 0 },
> +	{ "axp202", 0 },
> +	{ "axp209", 0 },
> +	{ "axp221", 0 },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(i2c, axp20x_i2c_id);

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
