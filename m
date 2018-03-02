From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Fri,  2 Mar 2018 18:57:52 +0100
Subject: [PATCH v9 0/5] rockchip: kevin: Enable edp display
Message-ID: <20180302175757.28192-1-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Actually the name of this patch series is not really true as the edp
display is working, but to not confuse I decided to maintain it. Now this
patchset is more a group of cleanups, the patchset has been originally
posted by Jeffy Chen and the 2 first commits from a previous version (v6)
are already merged in mainline. In v8, four patches more landed. And
this version are the remaining patches.

Regards,
 Enric

Changes in v9:
- The following patches from v8 has been applied:
  - [PATCH v8 1/8] drm/bridge: analogix: Do not use device's drvdata
  - [PATCH v8 2/8] drm/bridge: analogix_dp: Fix connector and encoder
    cleanup
  - [PATCH v8 3/8] drm/rockchip: analogix_dp: Add a sanity check for
    rockchip_drm_psr_register()
- The following patches from v8 has been superseeded.
  - [PATCH v8 7/8] drm/bridge/synopsys: dw-hdmi: Do not use device's
    drvdata
    - Superseeded by https://cgit.freedesktop.org/drm/drm-misc/commit/?id=eea034af90c64802fd747a9dc534c26a7ebe7754
- Moved clk_disable_unprepare reordering in unbin to separate patch.
- Added new patch to reorder clk_disable_unprepare call in inno_hdmi
  unbind()
- dw_hdmi: Rewrite the commit message to reflect the change.

Jeffy Chen (5):
  drm/rockchip: dw-mipi-dsi: Fix connector and encoder cleanup.
  drm/rockchip: inno_hdmi: Fix error handling path.
  drm/rockchip: inno_hdmi: reorder clk_disable_unprepare call in unbind
  drm/rockchip: dw_hdmi: Move HDMI vpll clock enable to bind()
  drm/bridge/synopsys: dw-hdmi: Add missing bridge detach

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c   |  8 ++++++++
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c      |  8 ++++++--
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 17 +++++++++--------
 drivers/gpu/drm/rockchip/inno_hdmi.c        | 22 +++++++++++++++++-----
 4 files changed, 40 insertions(+), 15 deletions(-)

-- 
2.16.1
