From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 28 Apr 2014 11:28:00 -0600
Subject: [PATCH 07/16] ARM: l2c: convert tegra to generic l2c
 initialisation
In-Reply-To: <E1Weoso-0002Pj-LE@rmk-PC.arm.linux.org.uk>
References: <20140428165631.GM26756@n2100.arm.linux.org.uk>
 <E1Weoso-0002Pj-LE@rmk-PC.arm.linux.org.uk>
Message-ID: <535E8FA0.6040205@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/28/2014 10:58 AM, Russell King wrote:

> diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c

>  DT_MACHINE_START(TEGRA_DT, "NVIDIA Tegra SoC (Flattened Device Tree)")
> -	.map_io		= tegra_map_common_io,
>  	.smp		= smp_ops(tegra_smp_ops),
> +	.l2c_aux_val	= 0x3c400001,
> +	.l2c_aux_mask	= 0xc20fc3fe,
> +	.map_io		= tegra_map_common_io,

I'm not sure why .map_io was moved. Was it to sort the entries in order
of execution? If so, I assume that .smp should be moved too?
