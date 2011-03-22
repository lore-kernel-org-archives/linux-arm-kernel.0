From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 22 Mar 2011 14:18:49 +0300
Subject: [PATCH] msm: board-msm8960: Add USB peripheral and OTG support
In-Reply-To: <1300783908-4638-1-git-send-email-anjir@codeaurora.org>
References: <1300783908-4638-1-git-send-email-anjir@codeaurora.org>
Message-ID: <4D888599.4080705@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 22-03-2011 11:51, Anji jonnala wrote:

> Signed-off-by: Anji jonnala <anjir@codeaurora.org>
[...]

> diff --git a/arch/arm/mach-msm/devices-msm8960.c b/arch/arm/mach-msm/devices-msm8960.c
> index 894ff98..8baf4fa 100644
> --- a/arch/arm/mach-msm/devices-msm8960.c
> +++ b/arch/arm/mach-msm/devices-msm8960.c
[...]
> @@ -89,6 +90,52 @@ struct platform_device msm8960_device_uart_gsbi5 = {
>   	.resource	= resources_uart_gsbi5,
>   };
>
> +static struct resource resources_otg[] = {
> +	{
> +		.start	= MSM8960_HSUSB_PHYS,
> +		.end	= MSM8960_HSUSB_PHYS + MSM8960_HSUSB_SIZE,

    You forgot "- 1".

> +		.flags	= IORESOURCE_MEM,
> +	},
> +	{
> +		.start	= USB1_HS_IRQ,
> +		.end	= USB1_HS_IRQ,
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +};
> +
> +struct platform_device msm_device_otg = {
> +	.name		= "msm_otg",
> +	.id		= -1,
> +	.num_resources	= ARRAY_SIZE(resources_otg),
> +	.resource	= resources_otg,
> +	.dev		= {
> +		.coherent_dma_mask	= 0xffffffff,
> +	},
> +};
> +
> +static struct resource resources_hsusb[] = {
> +	{
> +		.start	= MSM8960_HSUSB_PHYS,
> +		.end	= MSM8960_HSUSB_PHYS + MSM8960_HSUSB_SIZE,

    You forgot "- 1" here too.

WBR, Sergei
