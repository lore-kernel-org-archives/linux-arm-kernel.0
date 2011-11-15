From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 15 Nov 2011 18:53:52 +0900
Subject: [PATCH 1/2] ARM: SAMSUNG: Add pm_caps into platform data
In-Reply-To: <1320685522-17481-2-git-send-email-sangwook.lee@linaro.org>
References: <1320685522-17481-1-git-send-email-sangwook.lee@linaro.org>
 <1320685522-17481-2-git-send-email-sangwook.lee@linaro.org>
Message-ID: <005c01cca37c$7b8afc00$72a0f400$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sangwook Lee wrote:
> 
> Add pm_caps into platform_data. This is power management, usually
> for SDIO device such as SDIO WLAN.
> 
> Signed-off-by: Sangwook Lee <sangwook.lee@samsung.com>
> ---
>  arch/arm/plat-samsung/dev-hsmmc3.c         |    2 ++
>  arch/arm/plat-samsung/include/plat/sdhci.h |    2 ++
>  2 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-samsung/dev-hsmmc3.c
b/arch/arm/plat-samsung/dev-
> hsmmc3.c
> index ede776f..8f467f2 100644
> --- a/arch/arm/plat-samsung/dev-hsmmc3.c
> +++ b/arch/arm/plat-samsung/dev-hsmmc3.c
> @@ -78,6 +78,8 @@ void s3c_sdhci3_set_platdata(struct s3c_sdhci_platdata
*pd)
>  		set->cfg_card = pd->cfg_card;
>  	if (pd->host_caps)
>  		set->host_caps |= pd->host_caps;
> +	if (pd->pm_caps)
> +		set->pm_caps |= pd->pm_caps;
>  	if (pd->clk_type)
>  		set->clk_type = pd->clk_type;
>  }
> diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-
> samsung/include/plat/sdhci.h
> index 058e096..35646de 100644
> --- a/arch/arm/plat-samsung/include/plat/sdhci.h
> +++ b/arch/arm/plat-samsung/include/plat/sdhci.h
> @@ -40,6 +40,7 @@ enum clk_types {
>   * struct s3c_sdhci_platdata() - Platform device data for Samsung SDHCI
>   * @max_width: The maximum number of data bits supported.
>   * @host_caps: Standard MMC host capabilities bit field.
> + * @pm_caps: SDIO host PM capabilities bit field.
>   * @cd_type: Type of Card Detection method (see cd_types enum above)
>   * @clk_type: Type of clock divider method (see clk_types enum above)
>   * @ext_cd_init: Initialize external card detect subsystem. Called on
> @@ -67,6 +68,7 @@ enum clk_types {
>  struct s3c_sdhci_platdata {
>  	unsigned int	max_width;
>  	unsigned int	host_caps;
> +	unsigned int	pm_caps;
>  	enum cd_types	cd_type;
>  	enum clk_types	clk_type;
> 
> --
> 1.7.4.1

Hi Sangwook,

I think you need to re-work based on latest my for-next.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
