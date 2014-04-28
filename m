From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 28 Apr 2014 14:24:32 -0600
Subject: [PATCH 71/97] ARM: l2c: convert tegra to generic l2c
 initialisation
In-Reply-To: <E1WerHi-0001YW-Oi@rmk-PC.arm.linux.org.uk>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
 <E1WerHi-0001YW-Oi@rmk-PC.arm.linux.org.uk>
Message-ID: <535EB900.6010506@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/28/2014 01:32 PM, Russell King wrote:

> diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c

>  DT_MACHINE_START(TEGRA_DT, "NVIDIA Tegra SoC (Flattened Device Tree)")
> -	.map_io		= tegra_map_common_io,
> +	.l2c_aux_val	= 0x3c400001,
> +	.l2c_aux_mask	= 0xc20fc3fe,

I assume those values are simply ignored for CPUs without an l2c (or
with an architected one?) i.e. A15. If so,

Acked-by: Stephen Warren <swarren@nvidia.com>
