From: mark.yao@rock-chips.com (Mark yao)
Date: Wed, 06 Jan 2016 10:04:43 +0800
Subject: [PATCH v6.3 4/6] drm: rockchip: Support Synopsys DW MIPI DSI
In-Reply-To: <1450842215-10883-1-git-send-email-zyw@rock-chips.com>
References: <1450260616-21160-5-git-send-email-zyw@rock-chips.com>
 <1450842215-10883-1-git-send-email-zyw@rock-chips.com>
Message-ID: <568C763B.1030900@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?12?23? 11:43, Chris Zhong wrote:
> @@ -34,3 +34,13 @@ config ROCKCHIP_ANALOGIX_DP
>   	  This selects support for Rockchip SoC specific extensions
>   	  for the Analogix Core DP driver. If you want to enable DP
>   	  on RK3288 based SoC, you should selet this option.
> +
> +config ROCKCHIP_DW_MIPI_DSI
> +	bool "Rockchip specific extensions for Synopsys DW MIPI DSI"

I think "bool" should be "tristate", so dw mipi can build as modules,  
since ROCKCHIP_DW_HDMI use tristate.

Thanks.

> +	depends on DRM_ROCKCHIP
> +	select DRM_MIPI_DSI
> +	help
> +	 This selects support for Rockchip SoC specific extensions
> +	 for the Synopsys DesignWare HDMI driver. If you want to
> +	 enable MIPI DSI on RK3288 based SoC, you should selet this
> +	 option.


-- 
?ark Yao
