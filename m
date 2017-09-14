From: adrian.hunter@intel.com (Adrian Hunter)
Date: Thu, 14 Sep 2017 09:34:51 +0300
Subject: [PATCH v1 5/5] mmc: Kconfig: Enable CONFIG_MMC_SDHCI_IO_ACCESSORS
In-Reply-To: <1504097509-58983-6-git-send-email-vviswana@codeaurora.org>
References: <1504097509-58983-1-git-send-email-vviswana@codeaurora.org>
 <1504097509-58983-6-git-send-email-vviswana@codeaurora.org>
Message-ID: <f10addc2-5d67-3d0e-fb61-50d42f96125e@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/08/17 15:51, Vijay Viswanath wrote:
> Enable CONFIG_MMC_SDHCI_IO_ACCESSORS so that SDHC controller specific
> register read and write APIs, if registered, can be used.

Missing signed-off

Why don't you put this patch earlier in the patch set and then you don't
need all the ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS ?

> ---
>  drivers/mmc/host/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 2db84dd..64a9298 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -420,6 +420,7 @@ config MMC_SDHCI_MSM
>  	tristate "Qualcomm SDHCI Controller Support"
>  	depends on ARCH_QCOM || (ARM && COMPILE_TEST)
>  	depends on MMC_SDHCI_PLTFM
> +	select CONFIG_MMC_SDHCI_IO_ACCESSORS

CONFIG_MMC_SDHCI_IO_ACCESSORS -> MMC_SDHCI_IO_ACCESSORS

>  	help
>  	  This selects the Secure Digital Host Controller Interface (SDHCI)
>  	  support present in Qualcomm SOCs. The controller supports
> 
