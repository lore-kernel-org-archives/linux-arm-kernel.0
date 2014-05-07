From: olof@lixom.net (Olof Johansson)
Date: Wed, 7 May 2014 09:48:16 -0700
Subject: [PATCH v5 06/14] ARM: mcpm: support 4 clusters
In-Reply-To: <1399473888-12947-7-git-send-email-haojian.zhuang@linaro.org>
References: <1399473888-12947-1-git-send-email-haojian.zhuang@linaro.org>
 <1399473888-12947-7-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20140507164816.GB12692@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 07, 2014 at 10:44:40PM +0800, Haojian Zhuang wrote:
> Add the CONFIG_MCPM_QUAD_CLUSTER configuration to enlarge cluster number
> from 2 to 4.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> ---
>  arch/arm/Kconfig            | 9 +++++++++
>  arch/arm/include/asm/mcpm.h | 5 +++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 0e52a2c..624829f 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1575,6 +1575,15 @@ config MCPM
>  	  for (multi-)cluster based systems, such as big.LITTLE based
>  	  systems.
>  
> +config MCPM_QUAD_CLUSTER
> +	bool "Enable Quad clusters in MCPM"
> +	depends on MCPM
> +	help
> +	  To avoid wasting resources unnecessarily, MCPM only supports up
> +	  to 2 clusters by default.
> +	  Platforms with 3 or 4 clusters that use MCPM must select this
> +	  option to allow the additional clusters to be managed.
> +

Why don't you add an integer config instead, i.e. MCPM_MAX_CLUSTERS, and let
that set MAX_NR_CLUSTERS?


-Olof
