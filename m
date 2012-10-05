From: robherring2@gmail.com (Rob Herring)
Date: Fri, 05 Oct 2012 13:13:08 -0500
Subject: [PATCH 04/10] of/i2c: Add support for I2C_CLIENT_WAKE when booting
 with Device Tree
In-Reply-To: <1349451107-8009-5-git-send-email-lee.jones@linaro.org>
References: <1349451107-8009-1-git-send-email-lee.jones@linaro.org>
 <1349451107-8009-5-git-send-email-lee.jones@linaro.org>
Message-ID: <506F2334.1040009@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/05/2012 10:31 AM, Lee Jones wrote:
> It's important for wakeup sources such as keyboards, power buttons
> and the like to identify themselves as wakeup devices. Until now
> this has not been possible when platforms are booting via Device
> Tree.

A similar feature from Olof already went in for 3.7.

Rob

> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: devicetree-discuss at lists.ozlabs.org
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/of/of_i2c.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
> index 1e173f3..2f20019 100644
> --- a/drivers/of/of_i2c.c
> +++ b/drivers/of/of_i2c.c
> @@ -61,6 +61,9 @@ void of_i2c_register_devices(struct i2c_adapter *adap)
>  		info.of_node = of_node_get(node);
>  		info.archdata = &dev_ad;
>  
> +		if (of_get_property(node, "i2c-client-wake", NULL))
> +			info.flags |= I2C_CLIENT_WAKE;
> +
>  		request_module("%s%s", I2C_MODULE_PREFIX, info.type);
>  
>  		result = i2c_new_device(adap, &info);
> 
