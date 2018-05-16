From: briannorris@chromium.org (Brian Norris)
Date: Wed, 16 May 2018 16:28:47 -0700
Subject: [PATCH v4 4/4] drm/rockchip: support dp training outside dp
 firmware
In-Reply-To: <1526354560-23135-4-git-send-email-hl@rock-chips.com>
References: <1526354560-23135-1-git-send-email-hl@rock-chips.com>
 <1526354560-23135-4-git-send-email-hl@rock-chips.com>
Message-ID: <20180516232845.GA219198@rodete-desktop-imager.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2018 at 11:22:40AM +0800, Lin Huang wrote:
> DP firmware uses fixed phy config values to do training, but some
> boards need to adjust these values to fit for their unique hardware
> design. So get phy config values from dts and use software link training
> instead of relying on firmware, if software training fail, keep firmware
> training as a fallback if sw training fails.
> 
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> ---
> Changes in v2:
> - update patch following Enric suggest
> Changes in v3:
> - use variable fw_training instead sw_training_success
> - base on DP SPCE, if training fail use lower link rate to retry training
> Changes in v4:
> - improve cdn_dp_get_lower_link_rate() and cdn_dp_software_train_link() follow Sean suggest
> 
>  drivers/gpu/drm/rockchip/Makefile               |   3 +-
>  drivers/gpu/drm/rockchip/cdn-dp-core.c          |  24 +-
>  drivers/gpu/drm/rockchip/cdn-dp-core.h          |   2 +
>  drivers/gpu/drm/rockchip/cdn-dp-link-training.c | 420 ++++++++++++++++++++++++
>  drivers/gpu/drm/rockchip/cdn-dp-reg.c           |  31 +-
>  drivers/gpu/drm/rockchip/cdn-dp-reg.h           |  38 ++-
>  6 files changed, 505 insertions(+), 13 deletions(-)
>  create mode 100644 drivers/gpu/drm/rockchip/cdn-dp-link-training.c

Please rerun checkpatch next time. You've got a bunch of whitespace
issues in cdn_dp_get_lower_link_rate() and cdn_dp_software_train_link().

Brian
