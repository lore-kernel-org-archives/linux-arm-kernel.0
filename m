From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 15 May 2017 10:22:25 +0200
Subject: [PATCH v1 3/3] drm/stm: Add STM32 DSI host driver
In-Reply-To: <1494600989-13507-4-git-send-email-philippe.cornu@st.com>
References: <1494600989-13507-1-git-send-email-philippe.cornu@st.com>
 <1494600989-13507-4-git-send-email-philippe.cornu@st.com>
Message-ID: <a254c176-8064-1984-10b8-dce4308cc3d6@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/2017 04:56 PM, Philippe CORNU wrote:
> This mipi dsi host driver is based on the Rockchip version of the
> Synopsys Designware mipi dsi driver (rockchip/dw-mipi-dsi.c)
> modified for the stm32 family:
> - replace Rockchip digital & phy specific extensions with stm32's ones.
> - add a bridge
> 
> Signed-off-by: Philippe CORNU <philippe.cornu@st.com>
> ---
>  drivers/gpu/drm/stm/Kconfig       |    7 +
>  drivers/gpu/drm/stm/Makefile      |    2 +
>  drivers/gpu/drm/stm/dw-mipi-dsi.c | 1197 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 1206 insertions(+)
>  create mode 100644 drivers/gpu/drm/stm/dw-mipi-dsi.c
> 
> diff --git a/drivers/gpu/drm/stm/Kconfig b/drivers/gpu/drm/stm/Kconfig
> index 2c4817f..0007789 100644
> --- a/drivers/gpu/drm/stm/Kconfig
> +++ b/drivers/gpu/drm/stm/Kconfig
> @@ -14,3 +14,10 @@ config DRM_STM
>  	  STMicroelectronics STM32 MCUs.
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called stm-drm.
> +
> +config DRM_STM_DSI
> +	tristate "MIPI DSI support for STMicroelectronics SoC"
> +	depends on DRM_STM
> +	select DRM_MIPI_DSI
> +	help
> +	  Choose this option for MIPI DSI support on STMicroelectronics SoC.
> diff --git a/drivers/gpu/drm/stm/Makefile b/drivers/gpu/drm/stm/Makefile
> index e114d45..e448a93 100644
> --- a/drivers/gpu/drm/stm/Makefile
> +++ b/drivers/gpu/drm/stm/Makefile
> @@ -4,4 +4,6 @@ stm-drm-y := \
>  	drv.o \
>  	ltdc.o
>  
> +obj-$(CONFIG_DRM_STM_DSI) += dw-mipi-dsi.o
> +
>  obj-$(CONFIG_DRM_STM) += stm-drm.o
> diff --git a/drivers/gpu/drm/stm/dw-mipi-dsi.c b/drivers/gpu/drm/stm/dw-mipi-dsi.c
> new file mode 100644
> index 0000000..4b7f7b9
> --- /dev/null
> +++ b/drivers/gpu/drm/stm/dw-mipi-dsi.c


Hi Philippe,

First question, why couldn't this be transformed as a bridge driver along the Synopsys DW-HDMI driver ?

Neil
