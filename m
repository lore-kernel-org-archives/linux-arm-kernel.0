From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 11 Feb 2011 21:50:20 +0300
Subject: [PATCH v2 11/13] da850: pruss SUART board specific additions.
In-Reply-To: <1297435892-28278-12-git-send-email-subhasish@mistralsolutions.com>
References: <1297435892-28278-1-git-send-email-subhasish@mistralsolutions.com>
	<1297435892-28278-12-git-send-email-subhasish@mistralsolutions.com>
Message-ID: <4D5584EC.4070506@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Subhasish Ghosh wrote:

> This patch adds the pruss SUART pin mux and registers the device
> with the pruss mfd driver.

> Signed-off-by: Subhasish Ghosh <subhasish@mistralsolutions.com>
> ---
>  arch/arm/mach-davinci/board-da850-evm.c |   36 +++++++++++++++++++++++++++++++
>  1 files changed, 36 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
> index f9c38f8..3858516 100644
> --- a/arch/arm/mach-davinci/board-da850-evm.c
> +++ b/arch/arm/mach-davinci/board-da850-evm.c
[...]
> @@ -1085,6 +1104,17 @@ static int __init da850_evm_setup_pruss_can(void)
>  	return ret;
>  }
>  
> +static struct da850_evm_pruss_suart_data suart_data = {
> +	.version	= 1,
> +	.resource	= {
> +			.name	= "da8xx_mcasp0_iomem",
> +			.start	= DAVINCI_DA8XX_MCASP0_REG_BASE,
> +			.end	= DAVINCI_DA8XX_MCASP0_REG_BASE +
> +					(SZ_1K * 12) - 1,
> +			.flags	= IORESOURCE_MEM,
> +		},
> +};
> +

    I don't think passing a resource thru platform data is good idea... 
Resources should be bound to the platform device.

WBR, Sergei
