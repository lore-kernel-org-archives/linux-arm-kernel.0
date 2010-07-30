From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 30 Jul 2010 09:54:43 +0200
Subject: [PATCH] spi: add spi_tegra driver
In-Reply-To: <1280450224-25118-1-git-send-email-ccross@google.com>
References: <1280450224-25118-1-git-send-email-ccross@google.com>
Message-ID: <20100730075443.GA17814@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Colin Cross wrote:
> From: Erik Gilling <konkers@android.com>
> 
> CC: spi-devel-general at lists.sourceforge.net
> Signed-off-by: Erik Gilling <konkers@android.com>
> ---
> This patch depends on the Tegra APB DMA driver:
> [PATCH] [ARM] tegra: Add APB DMA support
> ---
>  drivers/spi/Kconfig     |    6 +
>  drivers/spi/Makefile    |    1 +
>  drivers/spi/spi_tegra.c |  651 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 658 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/spi/spi_tegra.c
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 91c2f4f..c07e0de 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -298,6 +298,12 @@ config SPI_STMP3XXX
>  	help
>  	  SPI driver for Freescale STMP37xx/378x SoC SSP interface
>  
> +config SPI_TEGRA
> +	tristate "Nvidia Tegra SPI controller"
> +	depends on ARCH_TEGRA
> +	help
> +	  SPI driver for NVidia Tegra SoCs
> +
[...]

Since you say this driver depends on the APB DMA driver, should this not be
expressed as a Kconfig dependency? Something like:

	select TEGRA_SYSTEM_DMA

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100730/2c9c6a2d/attachment-0001.sig>
