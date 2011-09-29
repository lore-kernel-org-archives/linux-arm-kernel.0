From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 29 Sep 2011 10:04:15 -0700
Subject: [PATCH v5 3/3] arm/tegra: device tree support for ventana board
In-Reply-To: <1317248978-10829-4-git-send-email-pdeschrijver@nvidia.com>
References: <1317248978-10829-1-git-send-email-pdeschrijver@nvidia.com>
	<1317248978-10829-4-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173A2C6717@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver wrote at Wednesday, September 28, 2011 4:30 PM:
...
> diff --git a/arch/arm/mach-tegra/board-dt.c b/arch/arm/mach-tegra/board-dt.c
...
> @@ -80,9 +80,19 @@ static struct of_device_id tegra_dt_gic_match[] __initdata = {
>  	{}
>  };
> 
> +static struct {
> +	char *machine;
> +	void (*init)(void);
> +} pinmux_configs[] = {
> +	{ "nvidia,harmony", harmony_pinmux_init() },
> +	{ "nvidia,seaboard", seaboard_pinmux_init() },
> +	{ "nvidia,ventana", ventana_pinmux_init() },
> +};

Do you want the brackets after the function names there? Locally, they
cause the following syntax errors during compilation:

arch/arm/mach-tegra/board-dt.c:85: error: initializer element is not constant
arch/arm/mach-tegra/board-dt.c:85: error: (near initialization for 'pinmux_configs[0].init')
arch/arm/mach-tegra/board-dt.c:86: error: initializer element is not constant
arch/arm/mach-tegra/board-dt.c:86: error: (near initialization for 'pinmux_configs[1].init')
arch/arm/mach-tegra/board-dt.c:87: error: initializer element is not constant
arch/arm/mach-tegra/board-dt.c:87: error: (near initialization for 'pinmux_configs[2].init')

(using gcc version 4.4.3 (gcc-4.4.3_cos_gg_51096))

-- 
nvpublic
