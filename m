From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 12 Mar 2018 14:06:52 +0000
Subject: [PATCH v5 1/4] mfd: syscon: Set name of regmap_config
In-Reply-To: <20180312095142.30854-2-jeffy.chen@rock-chips.com>
References: <20180312095142.30854-1-jeffy.chen@rock-chips.com>
 <20180312095142.30854-2-jeffy.chen@rock-chips.com>
Message-ID: <20180312140652.7ffdls4pccih32vk@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Mar 2018, Jeffy Chen wrote:

> We are now allowing to register debugfs without a valid device, and not
> having a valid name will end up using "dummy*" to create debugfs dir.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v5:
> CC lee.jones at linaro.org
> 
> Changes in v4: None
> Changes in v3:
> Modify commit message.
> 
>  drivers/mfd/syscon.c | 1 +
>  1 file changed, 1 insertion(+)

Looks okay.  Applied, thanks.

> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> index fc9ba0ea4e44..b6d05cd934e6 100644
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -110,6 +110,7 @@ static struct syscon *of_syscon_register(struct device_node *np)
>  	syscon_config.reg_stride = reg_io_width;
>  	syscon_config.val_bits = reg_io_width * 8;
>  	syscon_config.max_register = resource_size(&res) - reg_io_width;
> +	syscon_config.name = of_node_full_name(np);
>  
>  	regmap = regmap_init_mmio(NULL, base, &syscon_config);
>  	if (IS_ERR(regmap)) {

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
