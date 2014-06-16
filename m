From: mporter@linaro.org (Matt Porter)
Date: Mon, 16 Jun 2014 13:51:56 -0400
Subject: [PATCH] ARM: multi_v7_defconfig: re-enable SDHCI drivers
In-Reply-To: <1402937442-7623-1-git-send-email-swarren@wwwdotorg.org>
References: <1402937442-7623-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20140616175156.GF4173@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 16, 2014 at 10:50:42AM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Following 5d01b7684b7e "mmc: simplify SDHCI Kconfig dependencies",
> SDHCI drivers that use MMC_SDHCI_PLTFM no longer select it, but
> instead depend on it. This means that multi_v7_defconfig no longer
> selects it, and hence many SDHCI drivers are no longer enabled.
> Explicitly enable MMC_SDHCI_PLTFM to solve this.
> 
> Fixes: 5d01b7684b7e ("mmc: simplify SDHCI Kconfig dependencies")
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> This is a fix for 3.16, and based directly on v3.16-rc1.
> 
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Thanks, fixes the boot failure on my BCM mobile boards. I'm posting the
equivalent for our own defconfig.

Tested-by: Matt Porter <mporter@linaro.org>
