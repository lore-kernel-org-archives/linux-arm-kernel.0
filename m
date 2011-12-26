From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 26 Dec 2011 10:13:53 +0800
Subject: [PATCH] ARM: imx6q: build pm code only when CONFIG_PM selected
In-Reply-To: <1324478303-3899-1-git-send-email-eric.miao@linaro.org>
References: <1324478303-3899-1-git-send-email-eric.miao@linaro.org>
Message-ID: <20111226021352.GM8240@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 21, 2011 at 10:38:23PM +0800, Eric Miao wrote:
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Eric Miao <eric.miao@linaro.org>
> ---
>  arch/arm/mach-imx/Kconfig               |    1 +
>  arch/arm/mach-imx/Makefile              |    6 +++++-
>  arch/arm/mach-imx/head-v7.S             |    2 ++
>  arch/arm/plat-mxc/include/mach/common.h |    8 +++++++-
>  4 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index c44aa97..6ee6803 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -602,6 +602,7 @@ config SOC_IMX6Q
>  	select HAVE_IMX_GPC
>  	select HAVE_IMX_MMDC
>  	select HAVE_IMX_SRC
> +	select ARM_CPU_SUSPEND if PM

This needs to be sorted alphabetically.  I fixed it up and queued for
3.3.

Regards,
Shawn

>  	select USE_OF
>  
