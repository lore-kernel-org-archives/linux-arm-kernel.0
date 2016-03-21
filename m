From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 21 Mar 2016 11:54:10 +0000
Subject: [PATCH 2/4] mfd: axp20x: Add AXP209 GPIO driver to the mfd
In-Reply-To: <1457520614-32239-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1457520614-32239-1-git-send-email-maxime.ripard@free-electrons.com>
 <1457520614-32239-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20160321115410.GC4140@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 09 Mar 2016, Maxime Ripard wrote:

> Now that we have a GPIO driver for the AXP209, we can add it to our MFD.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/mfd/axp20x.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.

> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index a57d6e940610..89518ee3be33 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -430,6 +430,9 @@ static const struct regmap_irq_chip axp288_regmap_irq_chip = {
>  
>  static struct mfd_cell axp20x_cells[] = {
>  	{
> +		.name		= "axp20x-gpio",
> +		.of_compatible	= "x-powers,axp209-gpio",
> +	}, {
>  		.name		= "axp20x-pek",
>  		.num_resources	= ARRAY_SIZE(axp20x_pek_resources),
>  		.resources	= axp20x_pek_resources,

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
