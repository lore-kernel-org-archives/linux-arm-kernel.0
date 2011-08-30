From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 30 Aug 2011 11:40:36 +0800
Subject: [PATCH 1/2] sdhci/tegra: Add Device Tree probing support
In-Reply-To: <1314123334-23133-1-git-send-email-swarren@nvidia.com>
References: <1314123334-23133-1-git-send-email-swarren@nvidia.com>
Message-ID: <20110830034035.GC19294@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2011 at 12:15:33PM -0600, Stephen Warren wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> Add hooks to read gpio configuration out of the device tree node.
> 
> [grant.likely: Rewrite of original patch from John Bonesio]
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> [swarren: Fixed tegra_sdhci_get_ro() to retrieve pdata correctly]
> [swarren: Reworked to avoid #ifdef CONFIG_OF]
> [swarren: Reworked binding based on fsl-imx-esdhc.txt]
> [swarren: Documented binding]
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> Theoretically, these two patches should be merged in order in one place,
> since the 2nd logically depends on the first. However, it's really just
> a documentation dependency, so I think it's fine to merge them into the
> MMC and DT trees separately and let them meet in linux-next.
> 
>  .../devicetree/bindings/mmc/nvidia-sdhci.txt       |   25 ++++++++++
>  drivers/mmc/host/sdhci-tegra.c                     |   51 +++++++++++++++----
>  2 files changed, 65 insertions(+), 11 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/nvidia-sdhci.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/nvidia-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia-sdhci.txt
> new file mode 100644
> index 0000000..c87f667
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/nvidia-sdhci.txt
> @@ -0,0 +1,25 @@
> +* NVIDIA Tegra Secure Digital Host Controller
> +
> +This controller on Tegra family SoCs provides an interface for MMC, SD,
> +and SDIO types of memory cards.
> +
> +Required properties:
> +- compatible : Should be "nvidia,<chip>-sdhci"
> +- reg : Should contain eSDHC registers location and length
> +- interrupts : Should contain eSDHC interrupt

You may want to replace eSDHC with something Tegra specific.

-- 
Regards,
Shawn
