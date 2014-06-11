From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 11 Jun 2014 10:53:24 +0100
Subject: [PATCH] clk: Remove X-Gene "default y" from Kconfig
In-Reply-To: <20140609204357.920.35231.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140609204357.920.35231.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <20140611095324.GG23110@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 09, 2014 at 09:43:57PM +0100, Bjorn Helgaas wrote:
> Not all arm64 systems will have APM X-Gene clocks, so don't enable the
> driver by default in the Kconfig file.
> 
> There's only one arm64 defconfig, so I turned on CONFIG_COMMON_CLK_XGENE
> there to preserve the previous behavior of building the X-Gene driver by
> default.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/arm64/configs/defconfig |    1 +
>  drivers/clk/Kconfig          |    1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 157e1d8d9a47..59ddc931836b 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -113,3 +113,4 @@ CONFIG_CRYPTO_AES_ARM64_CE=y
>  CONFIG_CRYPTO_AES_ARM64_CE_CCM=y
>  CONFIG_CRYPTO_AES_ARM64_CE_BLK=y
>  CONFIG_CRYPTO_AES_ARM64_NEON_BLK=y
> +CONFIG_COMMON_CLK_XGENE=y
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 9f9c5ae5359b..52f11f8a0301 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -90,7 +90,6 @@ config CLK_PPC_CORENET
>  
>  config COMMON_CLK_XGENE
>  	bool "Clock driver for APM XGene SoC"
> -	default y
>  	depends on ARM64
>  	---help---
>  	  Sypport for the APM X-Gene SoC reference, PLL, and device clocks.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
