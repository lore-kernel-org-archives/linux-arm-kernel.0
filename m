From: stanley.miao@windriver.com (stanley.miao)
Date: Tue, 25 Jan 2011 16:57:16 +0800
Subject: [PATCH V5 25/63] ST SPEAr: Adding machine support for nand
In-Reply-To: <4388cfaa47bd0ee1c511e997c50ee5375142593c.1295499394.git.viresh.kumar@st.com>
References: <cover.1295499392.git.viresh.kumar@st.com>
	<4388cfaa47bd0ee1c511e997c50ee5375142593c.1295499394.git.viresh.kumar@st.com>
Message-ID: <4D3E906C.50206@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Viresh Kumar wrote:
> From: Vipin Kumar <vipin.kumar@st.com>
>
> <snip>
>  
> +/* nand device registeration */
> +static struct fsmc_nand_platform_data nand_platform_data;
> +
> +static struct resource nand_resources[] = {
> +	{
> +		.name = "nand_data",
> +		.start = SPEAR6XX_ICM1_NAND_BASE,
> +		.end = SPEAR6XX_ICM1_NAND_BASE + SZ_16 - 1,
> +		.flags = IORESOURCE_MEM,
> +	}, {
> +		.name = "fsmc_regs",
> +		.start = SPEAR6XX_ICM1_FSMC_BASE,
> +		.end = SPEAR6XX_ICM1_FSMC_BASE + SZ_4K - 1,
> +		.flags = IORESOURCE_MEM,
> +	},
> +};
> +
> +struct platform_device nand_device = {
> +	.name = "nand",
>   

fsmc-nand ?

Stanley.

> +	.id = -1,
> +	.resource = nand_resources,
> +	.num_resources = ARRAY_SIZE(nand_resources),
> +	.dev.platform_data = &nand_platform_data,
> +};
> +
>  /* usb host device registeration */
>  static struct resource ehci0_resources[] = {
>  	[0] = {
>   
