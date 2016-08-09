From: wsa-dev@sang-engineering.com (Wolfram Sang)
Date: Tue,  9 Aug 2016 13:30:26 +0200
Subject: [PATCH 0/5] gpu: don't print error when adding adapter fails
Message-ID: <1470742232-12559-1-git-send-email-wsa-dev@sang-engineering.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since v4.8-rc1, the I2C core will print detailed information when adding an I2C
adapter fails. So, drivers can skip this now.

Should go via subsystem tree, I'd think.

Wolfram Sang (5):
  gpu: drm: amd: amdgpu: amdgpu_i2c: don't print error when adding
    adapter fails
  gpu: drm: mediatek: mtk_hdmi_ddc: don't print error when adding
    adapter fails
  gpu: drm: msm: hdmi: hdmi_i2c: don't print error when adding adapter
    fails
  gpu: drm: radeon: radeon_i2c: don't print error when adding adapter
    fails
  gpu: drm: rockchip: inno_hdmi: don't print error when adding adapter
    fails

 drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c | 4 +---
 drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c | 4 +---
 drivers/gpu/drm/msm/hdmi/hdmi_i2c.c     | 5 +----
 drivers/gpu/drm/radeon/radeon_i2c.c     | 8 ++------
 drivers/gpu/drm/rockchip/inno_hdmi.c    | 1 -
 5 files changed, 5 insertions(+), 17 deletions(-)

-- 
2.8.1
