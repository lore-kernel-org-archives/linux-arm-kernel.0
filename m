From: mark.yao@rock-chips.com (Mark yao)
Date: Fri, 18 Dec 2015 18:18:46 +0800
Subject: [PATCH v6.1 4/6] drm: rockchip: Support Synopsys DW MIPI DSI
In-Reply-To: <1450432074-19808-1-git-send-email-zyw@rock-chips.com>
References: <1450260616-21160-5-git-send-email-zyw@rock-chips.com>
 <1450432074-19808-1-git-send-email-zyw@rock-chips.com>
Message-ID: <5673DD86.7010304@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?12?18? 17:47, Chris Zhong wrote:
> +	if (drm_core_check_feature(drm, DRIVER_ATOMIC))
> +		drm_connector_init(drm, &dsi->connector,
> +				   &dw_mipi_dsi_atomic_connector_funcs,
> +				   DRM_MODE_CONNECTOR_DSI);
> +	else
> +		drm_connector_init(drm, &dsi->connector,
> +				   &dw_mipi_dsi_connector_funcs,
> +				   DRM_MODE_CONNECTOR_DSI);
> +
Hi Chris

Since only drm/rockchip use the dw_mipi, and drm/rockchip is converting 
to atomic API,
so I think legacy connector funcs is no needed.

Thanks.

-- ?ark Yao
