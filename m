From: mark.yao@rock-chips.com (Mark yao)
Date: Mon, 21 Dec 2015 15:31:16 +0800
Subject: [RFC PATCH v1 1/2] drm: rockchip/hdmi: add Innosilicon HDMI
 support
In-Reply-To: <1447227999-4842-1-git-send-email-ykk@rock-chips.com>
References: <1447227952-4787-1-git-send-email-ykk@rock-chips.com>
 <1447227999-4842-1-git-send-email-ykk@rock-chips.com>
Message-ID: <5677AAC4.1010405@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?11?11? 15:46, Yakir Yang wrote:
> +	hdmi->connector.polled = DRM_CONNECTOR_POLL_HPD;
> +
> +	drm_connector_helper_add(&hdmi->connector,
> +				 &inno_hdmi_connector_helper_funcs);
> +	drm_connector_init(drm, &hdmi->connector, &inno_hdmi_connector_funcs,
> +			   DRM_MODE_CONNECTOR_HDMIA);
> +
> +	hdmi->connector.encoder = encoder;

Pls remove "hdmi->connector.encoder = encoder;"

It would cause a error dump on atomic drm runtime:

WARNING: CPU: 3 PID: 74 at drivers/gpu/drm/drm_atomic_helper.c:682 
drm_atomic_helper_update_legacy_modeset_state+0x6c/0x200()

This issue can be explained from following thread:
https://lkml.org/lkml/2015/11/16/498

Thanks.

-- 
?ark Yao
