From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Thu, 22 Oct 2015 09:50:44 -0400
Subject: [PATCH] serial: msm_serial: Make config tristate
In-Reply-To: <1445468723-948-1-git-send-email-sboyd@codeaurora.org>
References: <1445468723-948-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20151022135044.GD4588@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[[PATCH] serial: msm_serial: Make config tristate] On 21/10/2015 (Wed 16:05) Stephen Boyd wrote:

> This driver works as a module, so mark it as a tristate config
> instead of a bool.
> 
> Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
> 
> I tested this with a busybox ramdisk that modprobes msm_serial and
> then runs a getty on ttyMSM0. This patch should supersede Paul's earlier
> patch that removes the module code from this driver.

Thanks, I'll drop my patch for this driver.

Paul.
--

> 
>  drivers/tty/serial/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 1aec4404062d..e4f35da3de27 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1044,7 +1044,7 @@ config SERIAL_SGI_IOC3
>  	  say Y or M.  Otherwise, say N.
>  
>  config SERIAL_MSM
> -	bool "MSM on-chip serial port support"
> +	tristate "MSM on-chip serial port support"
>  	depends on ARCH_QCOM
>  	select SERIAL_CORE
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
