From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 09 Jan 2013 17:40:01 -0800
Subject: [PATCH] ARM: Samsung: Export MIPI CSIS/DSIM PHY control functions
In-Reply-To: <1357226497-25166-1-git-send-email-s.nawrocki@samsung.com>
References: <1357226497-25166-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <00e201cdeed3$69b40cd0$3d1c2670$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sylwester Nawrocki wrote:
> 
> The s5p_csis_phy_enable/s5p_dsim_phy_enable functions are now used
> directly by corresponding drivers and thus need to be exported so
> the drivers can be built as modules.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/plat-samsung/setup-mipiphy.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/plat-samsung/setup-mipiphy.c b/arch/arm/plat-
> samsung/setup-mipiphy.c
> index 1474593..66df315 100644
> --- a/arch/arm/plat-samsung/setup-mipiphy.c
> +++ b/arch/arm/plat-samsung/setup-mipiphy.c
> @@ -8,6 +8,7 @@
>   * published by the Free Software Foundation.
>   */
> 
> +#include <linux/export.h>
>  #include <linux/kernel.h>
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
> @@ -50,8 +51,10 @@ int s5p_csis_phy_enable(int id, bool on)
>  {
>  	return __s5p_mipi_phy_control(id, on, S5P_MIPI_DPHY_SRESETN);
>  }
> +EXPORT_SYMBOL(s5p_csis_phy_enable);
> 
>  int s5p_dsim_phy_enable(struct platform_device *pdev, bool on)
>  {
>  	return __s5p_mipi_phy_control(pdev->id, on,
> S5P_MIPI_DPHY_MRESETN);
>  }
> +EXPORT_SYMBOL(s5p_dsim_phy_enable);
> --
> 1.7.9.5

OK, applied.

Thanks.

- Kukjin
