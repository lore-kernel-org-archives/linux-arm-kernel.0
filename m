From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 22 Jun 2011 18:10:35 +0900
Subject: [PATCH] Samsung SoC: header file revised to prevent declaring
	duplicated.
In-Reply-To: <1308214064-12796-1-git-send-email-myungjoo.ham@samsung.com>
References: <1308213184-6607-1-git-send-email-myungjoo.ham@samsung.com>
	<1308214064-12796-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <00be01cc30bc$450ee250$cf2ca6f0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MyungJoo Ham wrote:
> 
> There has been no #ifndef - #define - #endif protection for this header
> file. The patch adds it for Exynos4-ADC support
> 
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> ---
>  arch/arm/plat-samsung/include/plat/devs.h |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-
> samsung/include/plat/devs.h
> index 4af108f..3c87779 100644
> --- a/arch/arm/plat-samsung/include/plat/devs.h
> +++ b/arch/arm/plat-samsung/include/plat/devs.h
> @@ -12,6 +12,9 @@
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
>  */
> +#ifndef __PLAT_DEVS_H
> +#define __PLAT_DEVS_H __FILE__
> +
>  #include <linux/platform_device.h>
> 
>  struct s3c24xx_uart_resources {
> @@ -159,3 +162,5 @@ extern struct platform_device s3c_device_ac97;
>   */
>  extern void *s3c_set_platdata(void *pd, size_t pdsize,
>  			      struct platform_device *pdev);
> +
> +#endif /* __PLAT_DEVS_H */
> --
> 1.7.4.1

OK, applied.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
