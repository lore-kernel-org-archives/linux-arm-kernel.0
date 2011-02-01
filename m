From: nsekhar@ti.com (Nori, Sekhar)
Date: Tue, 1 Feb 2011 17:51:58 +0530
Subject: [PATCH 2/4] davinci: add spi devices support for
	MityDSP-L138/MityARM-1808 platform
In-Reply-To: <1296518716-5004-3-git-send-email-michael.williamson@criticallink.com>
References: <1296518716-5004-1-git-send-email-michael.williamson@criticallink.com>
	<1296518716-5004-3-git-send-email-michael.williamson@criticallink.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930248777A4B@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Tue, Feb 01, 2011 at 05:35:14, Michael Williamson wrote:
> This patch adds support for accessing the on board SPI NOR FLASH
> device for MityDSP-L138 and MityARM-1808 SoMs.
> 
> Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
> Tested-by: Michael Williamson <michael.williamson@criticallink.com>
> ---
>  arch/arm/mach-davinci/board-mityomapl138.c |  104 ++++++++++++++++++++++++++++
>  1 files changed, 104 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c


> +
> +static struct davinci_spi_platform_data mityomapl138_spi1_pdata = {
> +	.version	= SPI_VERSION_2,
> +	.num_chipselect	= 1,
> +	.intr_line	= 1,
> +};

This platform data is better placed in devices-da8xx.c as most of
it is common across all DA8xx platforms. Only num_chipselect and
chip_sel array are expected to be board specific so only those should
be passed on from board files.

Thanks,
Sekhar
