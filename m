From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 19 Feb 2016 00:54:59 +0100
Subject: [PATCH v2 5/6] rockchip: power-domain: Modify power domain driver
 for rk3399
In-Reply-To: <1455764885-12979-1-git-send-email-zhangqing@rock-chips.com>
References: <1455764885-12979-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1977372.gr1KGjTNYc@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 18. Februar 2016, 11:08:05 schrieb Elaine Zhang:
> This driver is modified to support RK3399 SoC.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  drivers/soc/rockchip/pm_domains.c | 55
> +++++++++++++++++++++++++++++++++++++++ 1 file changed, 55 insertions(+)
> 
> diff --git a/drivers/soc/rockchip/pm_domains.c
> b/drivers/soc/rockchip/pm_domains.c index 8cdf1b2..067e655 100644
> --- a/drivers/soc/rockchip/pm_domains.c
> +++ b/drivers/soc/rockchip/pm_domains.c
> @@ -19,6 +19,7 @@
>  #include <linux/mfd/syscon.h>
>  #include <dt-bindings/power/rk3288-power.h>
>  #include <dt-bindings/power/rk3368-power.h>
> +#include <dt-bindings/power/rk3399-power.h>
> 
>  struct rockchip_domain_info {
>  	int pwr_mask;
> @@ -81,6 +82,9 @@ struct rockchip_pmu {
>  #define DOMAIN_RK3368(pwr, status, req)		\
>  	DOMAIN(pwr, status, req, (req) + 16, req)
> 
> +#define DOMAIN_RK3399(pwr, status, req)                \
> +	DOMAIN(pwr, status, req, req, req)
> +
>  static bool rockchip_pmu_domain_is_idle(struct rockchip_pm_domain *pd)
>  {
>  	struct rockchip_pmu *pmu = pd->pmu;
> @@ -522,6 +526,36 @@ static const struct rockchip_domain_info
> rk3368_pm_domains[] = { [RK3368_PD_GPU_1]	= DOMAIN_RK3368(17, 16, 2),
>  };
> 
> +static const struct rockchip_domain_info rk3399_pm_domains[] = {
> +	[RK3399_PD_TCPD0]       = DOMAIN_RK3399(8, 8, NULL_BIT),
> +	[RK3399_PD_TCPD1]       = DOMAIN_RK3399(9, 9, NULL_BIT),
> +	[RK3399_PD_CCI]         = DOMAIN_RK3399(10, 10, NULL_BIT),
> +	[RK3399_PD_CCI0]        = DOMAIN_RK3399(NULL_BIT, NULL_BIT, 15),
> +	[RK3399_PD_CCI1]        = DOMAIN_RK3399(NULL_BIT, NULL_BIT, 16),
> +	[RK3399_PD_PERILP]      = DOMAIN_RK3399(11, 11, 1),
> +	[RK3399_PD_PERIHP]      = DOMAIN_RK3399(12, 12, 2),
> +	[RK3399_PD_CENTER]      = DOMAIN_RK3399(13, 13, 14),
> +	[RK3399_PD_VIO]         = DOMAIN_RK3399(14, 14, 17),
> +	[RK3399_PD_GPU]         = DOMAIN_RK3399(15, 15, 0),
> +	[RK3399_PD_VCODEC]      = DOMAIN_RK3399(16, 16, 3),
> +	[RK3399_PD_VDU]         = DOMAIN_RK3399(17, 17, 4),
> +	[RK3399_PD_RGA]         = DOMAIN_RK3399(18, 18, 5),
> +	[RK3399_PD_IEP]         = DOMAIN_RK3399(19, 19, 6),
> +	[RK3399_PD_VO]          = DOMAIN_RK3399(20, 20, NULL_BIT),
> +	[RK3399_PD_VOPB]        = DOMAIN_RK3399(NULL_BIT, NULL_BIT, 7),
> +	[RK3399_PD_VOPL]        = DOMAIN_RK3399(NULL_BIT, NULL_BIT, 8),
> +	[RK3399_PD_ISP0]        = DOMAIN_RK3399(22, 22, 9),
> +	[RK3399_PD_ISP1]        = DOMAIN_RK3399(23, 23, 10),
> +	[RK3399_PD_HDCP]        = DOMAIN_RK3399(24, 24, 11),
> +	[RK3399_PD_GMAC]        = DOMAIN_RK3399(25, 25, 23),
> +	[RK3399_PD_EMMC]        = DOMAIN_RK3399(26, 26, 24),
> +	[RK3399_PD_USB3]        = DOMAIN_RK3399(27, 27, 12),
> +	[RK3399_PD_EDP]         = DOMAIN_RK3399(28, 28, 22),
> +	[RK3399_PD_GIC]         = DOMAIN_RK3399(29, 29, 27),
> +	[RK3399_PD_SD]          = DOMAIN_RK3399(30, 30, 28),
> +	[RK3399_PD_SDIOAUDIO]   = DOMAIN_RK3399(31, 31, 29),

tabs indead of spaces between [index] and "=" please

otherwise looks nice :-)


Heiko
