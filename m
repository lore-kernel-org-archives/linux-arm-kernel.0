From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 25 Nov 2013 21:27:47 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAyLzJdIEFSTSBpLk1YNTogc2V0IENBTiBwZXJpcGhlcmFs?=
 =?UTF-8?B?IGNsb2NrIHRvIDI0IE1IeiBwYXJlbnQ=?=
In-Reply-To: <1385399751-19109-3-git-send-email-mkl@pengutronix.de>
References: <1385399751-19109-1-git-send-email-mkl@pengutronix.de>
 <1385399751-19109-3-git-send-email-mkl@pengutronix.de>
Message-ID: <1385400467.906340545@f177.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This patch sets the parent of CAN peripheral clock (a.k.a. CPI clock) to the
> lp_apm clock, which has a rate of 24 MHz.
> 
> In the CAN world a base clock with multiple of 8 MHz is suited best for all CIA
> recommented bit rates. Without this patch the CAN peripheral clock on i.MX53
> has a rate of 66.666 MHz which produces quite large bit rate errors.
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  arch/arm/mach-imx/clk-imx51-imx53.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
> index e349fd5..28f7f3f 100644
> --- a/arch/arm/mach-imx/clk-imx51-imx53.c
> +++ b/arch/arm/mach-imx/clk-imx51-imx53.c
> @@ -306,6 +306,9 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
>  	/* move usb phy clk to 24MHz */
>  	clk_set_parent(clk[IMX5_CLK_USB_PHY_SEL], clk[IMX5_CLK_OSC]);
>  
> +	/* move can bus clk to 24MHz */
> +	clk_set_parent(clk[IMX5_CLK_CAN_SEL], clk[IMX5_CLK_LP_APM]);
> +
>  	clk_prepare_enable(clk[IMX5_CLK_GPC_DVFS]);
>  	clk_prepare_enable(clk[IMX5_CLK_AHB_MAX]); /* esdhc3 */
>  	clk_prepare_enable(clk[IMX5_CLK_AIPS_TZ1]);
> -- 

Again, CAN is missing on i.MX51, so this should be moved from common_init function.

---
