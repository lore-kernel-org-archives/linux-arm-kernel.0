From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 11 Jan 2012 13:49:41 -0800
Subject: [PATCH 07/15] ARM: tegra: convert to twd_local_timer_register()
 interface
In-Reply-To: <1326287334-1905-8-git-send-email-marc.zyngier@arm.com>
References: <1326287334-1905-1-git-send-email-marc.zyngier@arm.com>
 <1326287334-1905-8-git-send-email-marc.zyngier@arm.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF177EE3A7B3@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Zyngier wrote at Wednesday, January 11, 2012 6:09 AM:
> Add support for the new smp_twd runtime registration interface
> to the tegra platforms, and remove the old compile-time support.
> Tested on Harmony.
...
> diff --git a/arch/arm/mach-tegra/timer.c b/arch/arm/mach-tegra/timer.c
...
> +#ifdef CONFIG_HAVE_ARM_TWD
> +static struct twd_local_timer twd_local_timer __initdata = {
> +	.res =	{
> +		{
> +			.start	= TEGRA_ARM_PERIF_BASE + 0x600,
> +			.end	= TEGRA_ARM_PERIF_BASE + 0x610,

Don't you need to subtract 1 from .end there?

> +			.flags	= IORESOURCE_MEM,
> +		},

-- 
nvpublic
