From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 25 Nov 2013 14:37:27 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gQVJNIGkuTVg1OiBmaXggInNoaWZ0IiB2YWx1ZSBmb3Ig?=
 =?UTF-8?B?bHBfYXBtX3NlbA==?=
In-Reply-To: <1385375474-15901-1-git-send-email-mkl@pengutronix.de>
References: <1385375474-15901-1-git-send-email-mkl@pengutronix.de>
Message-ID: <1385375847.678349974@f369.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> According to the i.MX53 Rev. 2.1 datasheet the lp_apm_sel is bit 10 in the
> CCM_CCSR register not bit 9.
> 
> This patch fixes this issue.
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  arch/arm/mach-imx/clk-imx51-imx53.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
> index 3f01df2..867d623 100644
> --- a/arch/arm/mach-imx/clk-imx51-imx53.c
> +++ b/arch/arm/mach-imx/clk-imx51-imx53.c
> @@ -98,7 +98,7 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
>  	clk[IMX5_CLK_CKIH1]		= imx_obtain_fixed_clock("ckih1", rate_ckih1);
>  	clk[IMX5_CLK_CKIH2]		= imx_obtain_fixed_clock("ckih2", rate_ckih2);
>  
> -	clk[IMX5_CLK_LP_APM]		= imx_clk_mux("lp_apm", MXC_CCM_CCSR, 9, 1,
> +	clk[IMX5_CLK_LP_APM]		= imx_clk_mux("lp_apm", MXC_CCM_CCSR, 10, 1,
>  						lp_apm_sel, ARRAY_SIZE(lp_apm_sel));

This is not valid for i.MX51.

---
