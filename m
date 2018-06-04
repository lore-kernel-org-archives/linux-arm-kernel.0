From: rdunlap@infradead.org (Randy Dunlap)
Date: Mon, 4 Jun 2018 00:32:24 -0700
Subject: [PATCHv9 3/3] ARM:drm ivip Intel FPGA Video and Image Processing
 Suite
In-Reply-To: <1528094404-3542-4-git-send-email-hean.loong.ong@intel.com>
References: <1528094404-3542-1-git-send-email-hean.loong.ong@intel.com>
 <1528094404-3542-4-git-send-email-hean.loong.ong@intel.com>
Message-ID: <06e982ba-3701-b042-21b6-64f6f8744bba@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/2018 11:40 PM, Hean-Loong, Ong wrote:
> From: Ong Hean Loong <hean.loong.ong@intel.com>
> 
> Driver for Intel FPGA Video and Image Processing Suite Frame Buffer II.
> The driver only supports the Intel Arria10 devkit and its variants.
> This driver can be either loaded staticlly or in modules.
> The OF device tree binding is located at:
> Documentation/devicetree/bindings/display/altr,vip-fb2.txt
> 
> Signed-off-by: Ong Hean Loong <hean.loong.ong@intel.com>
> ---
>  drivers/gpu/drm/Kconfig               |    2 +
>  drivers/gpu/drm/Makefile              |    1 +
>  drivers/gpu/drm/ivip/Kconfig          |   14 +++
>  drivers/gpu/drm/ivip/Makefile         |    9 ++
>  drivers/gpu/drm/ivip/intel_vip_conn.c |   95 ++++++++++++++++
>  drivers/gpu/drm/ivip/intel_vip_core.c |  161 +++++++++++++++++++++++++++
>  drivers/gpu/drm/ivip/intel_vip_drv.h  |   52 +++++++++
>  drivers/gpu/drm/ivip/intel_vip_of.c   |  193 +++++++++++++++++++++++++++++++++
>  8 files changed, 527 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/gpu/drm/ivip/Kconfig
>  create mode 100644 drivers/gpu/drm/ivip/Makefile
>  create mode 100644 drivers/gpu/drm/ivip/intel_vip_conn.c
>  create mode 100644 drivers/gpu/drm/ivip/intel_vip_core.c
>  create mode 100644 drivers/gpu/drm/ivip/intel_vip_drv.h
>  create mode 100644 drivers/gpu/drm/ivip/intel_vip_of.c
> 
> diff --git a/drivers/gpu/drm/ivip/Kconfig b/drivers/gpu/drm/ivip/Kconfig
> new file mode 100644
> index 0000000..1d08b90
> --- /dev/null
> +++ b/drivers/gpu/drm/ivip/Kconfig
> @@ -0,0 +1,14 @@
> +config DRM_IVIP
> +        tristate "Intel FGPA Video and Image Processing"
> +        depends on DRM && OF
> +        select DRM_GEM_CMA_HELPER
> +        select DRM_KMS_HELPER
> +        select DRM_KMS_FB_HELPER
> +        select DRM_KMS_CMA_HELPER
> +        help
> +		  Choose this option if you have an Intel FPGA Arria 10 system
> +		  and above with an Intel Display Port IP. This does not support
> +		  legacy Intel FPGA Cyclone V display port. Currently only single
> +		  frame buffer is supported. Note that ACPI and X_86 architecture
> +		  is not supported for Arria10. If M is selected the module will be
> +		  called ivip.

Hi,

Kconfig help text is supposed to be indented with one tab + 2 spaces.

thanks,
-- 
~Randy
