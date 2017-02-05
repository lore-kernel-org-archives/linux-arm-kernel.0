From: mark.yao@rock-chips.com (Mark yao)
Date: Sun, 5 Feb 2017 16:42:23 +0800
Subject: [PATCH v17 0/7] drm/rockchip: Add CDN DP driver
In-Reply-To: <1486281302-28200-1-git-send-email-zyw@rock-chips.com>
References: <1486281302-28200-1-git-send-email-zyw@rock-chips.com>
Message-ID: <5896E56F.6020500@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris

Applied to my drm-next and already sent pull request to Dave.

Thanks.

On 2017?02?05? 15:54, Chris Zhong wrote:
> This series adds support for the CDN DP controller to the rockchip drm
> driver. This version fixes some coding style error in v16, it post by
> Sean Paul, you can find it here:
> 	https://patchwork.kernel.org/patch/9442135/
>
> And I sorted out a few patches to fix the following problems:
> - suspend/resume crash cause by drm_helper_hpd_irq_event
> - crash during shutdown when cdn-dp failed to bind
> - check sink count failed after reconnection
> - suspend/reusme crash in mode_set function
>
> I also added these 2 patches to this series, although nothing changed:
> https://patchwork.kernel.org/patch/9442141/
> https://patchwork.kernel.org/patch/9442151/
>
>
> Changes in v17:
> - Correct the clock check condition
> - Correct the coding style
> - change LANE_REF_CYC to 0x8000
>
> Chris Zhong (4):
>    drm/rockchip: cdn-dp: add cdn DP support for rk3399
>    drm/rockchip: cdn-dp: do not use drm_helper_hpd_irq_event
>    drm/rockchip: cdn-dp: retry to check sink count
>    drm/rockchip: cdn-dp: don't configure hardware in mode_set
>
> Guenter Roeck (2):
>    drm/rockchip: cdn-dp: Load firmware if no monitor connected
>    drm/rockchip: cdn-dp: Do not run worker while suspended
>
> Jeffy Chen (1):
>    drm/rockchip: cdn-dp: Move mutex_init to probe
>
>   drivers/gpu/drm/rockchip/Kconfig            |   10 +
>   drivers/gpu/drm/rockchip/Makefile           |    2 +
>   drivers/gpu/drm/rockchip/cdn-dp-core.c      | 1260 +++++++++++++++++++++++++++
>   drivers/gpu/drm/rockchip/cdn-dp-core.h      |  112 +++
>   drivers/gpu/drm/rockchip/cdn-dp-reg.c       |  979 +++++++++++++++++++++
>   drivers/gpu/drm/rockchip/cdn-dp-reg.h       |  483 ++++++++++
>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c |   13 +-
>   drivers/gpu/drm/rockchip/rockchip_drm_vop.h |    9 +
>   drivers/gpu/drm/rockchip/rockchip_vop_reg.c |    2 +
>   9 files changed, 2867 insertions(+), 3 deletions(-)
>   create mode 100644 drivers/gpu/drm/rockchip/cdn-dp-core.c
>   create mode 100644 drivers/gpu/drm/rockchip/cdn-dp-core.h
>   create mode 100644 drivers/gpu/drm/rockchip/cdn-dp-reg.c
>   create mode 100644 drivers/gpu/drm/rockchip/cdn-dp-reg.h
>


-- 
?ark Yao
