From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 23 Mar 2015 11:55:06 +0000
Subject: [PATCH v5 09/12] mfd: axp20x: Enable AXP22X regulators
In-Reply-To: <1425988764-23618-10-git-send-email-wens@csie.org>
References: <1425988764-23618-1-git-send-email-wens@csie.org>
 <1425988764-23618-10-git-send-email-wens@csie.org>
Message-ID: <20150323115506.GD24422@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 Mar 2015, Chen-Yu Tsai wrote:

> Now that the axp20x-regulators driver supports different variants of the
> AXP family, we can enable regulator support for AXP22X without the risk
> of incorrectly configuring regulators.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/mfd/axp20x.c | 2 ++
>  1 file changed, 2 insertions(+)

For my own reference:

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 0ec27d5023df..8d2dbb7eb588 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -370,6 +370,8 @@ static struct mfd_cell axp22x_cells[] = {
>  		.name			= "axp20x-pek",
>  		.num_resources		= ARRAY_SIZE(axp22x_pek_resources),
>  		.resources		= axp22x_pek_resources,
> +	}, {
> +		.name			= "axp20x-regulator",
>  	},
>  };
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
