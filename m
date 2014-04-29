From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 29 Apr 2014 11:21:33 +0100
Subject: [PATCH v4 06/14] ARM: mcpm: support 4 clusters
In-Reply-To: <1398668032-8335-7-git-send-email-haojian.zhuang@linaro.org>
References: <1398668032-8335-1-git-send-email-haojian.zhuang@linaro.org>
 <1398668032-8335-7-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20140429102133.GB3582@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 02:53:44PM +0800, Haojian Zhuang wrote:
> Add the CONFIG_MCPM_QUAD_CLUSTER configuration to enlarge cluster number
> from 2 to 4.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> ---
>  arch/arm/Kconfig            | 6 ++++++
>  arch/arm/include/asm/mcpm.h | 5 +++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 5ef96ea..58e995d 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1572,6 +1572,12 @@ config MCPM
>  	  for (multi-)cluster based systems, such as big.LITTLE based
>  	  systems.
>  
> +config MCPM_QUAD_CLUSTER
> +	bool "Enable Quad clusters in MCPM"
> +	depends on MCPM
> +	help
> +	  This option enables quad clusters in MCPM.

This is fairly self-explanatory, but to make things crystal clear
you could add an explanatory note about how this option should be used,
something like:

	  To avoid wasting resources unnecessarily, MCPM only supports up
	  to 2 clusters by default.

	  Platforms with 3 or 4 clusters that use MCPM must select this
	  option to allow the additional clusters to be managed.

Cheers
---Dave
