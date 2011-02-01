From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 01 Feb 2011 15:06:35 +0300
Subject: [PATCH 4/4] davinci: add spi devices support for
	da830/omap-l137/am17x evm
In-Reply-To: <1296518716-5004-5-git-send-email-michael.williamson@criticallink.com>
References: <1296518716-5004-1-git-send-email-michael.williamson@criticallink.com>
	<1296518716-5004-5-git-send-email-michael.williamson@criticallink.com>
Message-ID: <4D47F74B.9060309@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01-02-2011 3:05, Michael Williamson wrote:

> From: Sekhar Nori<nsekhar@ti.com>

> This patch adds the on-board SPI flash device to the
> DA830/OMAP-L137/AM17x EVM. It also registers the SPI flash
> device to the MTD subsystem.

> Based on SPI flash device support for MityDSP-L138F platform.

> Signed-off-by: Michael Williamson<michael.williamson@criticallink.com>

    Why Sekhar hasn't signed off on this patch?

> diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
> index b52a3a1..15077a0 100644
> --- a/arch/arm/mach-davinci/board-da830-evm.c
> +++ b/arch/arm/mach-davinci/board-da830-evm.c
[...]
> @@ -534,6 +537,83 @@ static struct edma_rsv_info da830_edma_rsv[] = {
>   	},
>   };
>
> +static struct davinci_spi_platform_data da830evm_spi0_pdata = {
> +	.version	= SPI_VERSION_2,
> +	.num_chipselect = 1,
> +	.intr_line      = 1,
> +};
> +
> +static struct mtd_partition da830evm_spiflash_part[] = {
> +	[0] = {
> +		.name = "DSP-UBL",
> +		.offset = 0,
> +		.size = SZ_8K,
> +		.mask_flags = MTD_WRITEABLE,
> +	},
> +	[1] = {
> +		.name = "ARM-UBL",
> +		.offset = MTDPART_OFS_APPEND,
> +		.size = SZ_16K + SZ_8K,
> +		.mask_flags = MTD_WRITEABLE,
> +	},
> +	[2] = {
> +		.name = "U-Boot",
> +		.offset = MTDPART_OFS_APPEND,
> +		.size = SZ_256K - SZ_32K,
> +		.mask_flags = MTD_WRITEABLE,
> +	},
> +	[3] = {
> +		.name = "U-Boot-Environment",
> +		.offset = MTDPART_OFS_APPEND,
> +		.size = SZ_16K,
> +		.mask_flags = 0,
> +	},
> +	[4] = {
> +		.name = "Kernel",
> +		.offset = MTDPART_OFS_APPEND,
> +		.size = MTDPART_SIZ_FULL,
> +		.mask_flags = 0,

    There's no need to explicitly init to 0.

WBR, Sergei
