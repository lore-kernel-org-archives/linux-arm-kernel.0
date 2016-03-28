From: mark.yao@rock-chips.com (Mark yao)
Date: Mon, 28 Mar 2016 14:45:02 +0800
Subject: [PATCH v2 1/5] drm/rockchip: dw_hdmi: Call drm_encoder_cleanup()
 in error path
In-Reply-To: <1457388054-23077-1-git-send-email-dianders@chromium.org>
References: <1457388054-23077-1-git-send-email-dianders@chromium.org>
Message-ID: <56F8D2EE.4080004@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016?03?08? 06:00, Douglas Anderson wrote:
> The drm_encoder_cleanup() was missing both from the error path of
> dw_hdmi_rockchip_bind().  This caused a crash when slub_debug was
> enabled and we ended up deferring probe of HDMI at boot.
>
> This call isn't needed from unbind() because if dw_hdmi_bind() returns
> no error then it takes over the job of freeing the encoder (in
> dw_hdmi_unbind).
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Hi Douglas

it seems has no doubt on these patch, and it works on my board, So I'd 
like to apply following three patches.

[PATCH v2 1/5] drm/rockchip: dw_hdmi: Call drm_encoder_cleanup() in 
error path
[PATCH v2 3/5] drm/rockchip: vop: Fix vop crtc cleanup
[PATCH v2 4/5] drm/rockchip: dw_hdmi: Don't call platform_set_drvdata()

Thanks for your fixes.

-- ?ark Yao
