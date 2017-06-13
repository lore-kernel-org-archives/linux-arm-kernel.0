From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 13 Jun 2017 09:39:59 -0700
Subject: [PATCH] bus: SIMPLE_PM_BUS does not depend on ARCH_RENESAS
In-Reply-To: <20170613130430.4272-1-robdclark@gmail.com>
References: <20170613130430.4272-1-robdclark@gmail.com>
Message-ID: <20170613163959.GU12920@tuxbook>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+cc Geert, Simon, linux-pm

On Tue 13 Jun 06:04 PDT 2017, Rob Clark wrote:

> In fact, it is needed for PCI to work on msm8996 (and probably other
> things).  No idea why it was depending on renesas but that doesn't make
> any sense.  So drop the dependency.
> 

This is in line with Geert's previous comments on how to utilize
simple-pm-bus to describe this hardware.

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

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
>  	help
>  	  Driver for transparent busses that don't need a real driver, but
>  	  where the bus controller is part of a PM domain, or under the control
> -- 
> 2.9.4
> 
