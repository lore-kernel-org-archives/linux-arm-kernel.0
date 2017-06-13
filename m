From: andy.gross@linaro.org (Andy Gross)
Date: Tue, 13 Jun 2017 16:48:41 -0400
Subject: [PATCH] bus: SIMPLE_PM_BUS does not depend on ARCH_RENESAS
In-Reply-To: <20170613130430.4272-1-robdclark@gmail.com>
References: <20170613130430.4272-1-robdclark@gmail.com>
Message-ID: <20170613204841.GG19546@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 13, 2017 at 09:04:30AM -0400, Rob Clark wrote:
> In fact, it is needed for PCI to work on msm8996 (and probably other
> things).  No idea why it was depending on renesas but that doesn't make
> any sense.  So drop the dependency.
> 
> Signed-off-by: Rob Clark <robdclark@gmail.com>
> ---
>  drivers/bus/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
> index 0a52da4..b83c535 100644
> --- a/drivers/bus/Kconfig
> +++ b/drivers/bus/Kconfig
> @@ -121,7 +121,6 @@ config QCOM_EBI2
>  config SIMPLE_PM_BUS
>  	bool "Simple Power-Managed Bus Driver"
>  	depends on OF && PM
> -	depends on ARCH_RENESAS || COMPILE_TEST

Do you really want to drop COMPILE_TEST?
