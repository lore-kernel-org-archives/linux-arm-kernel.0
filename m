From: ykk@rock-chips.com (Yakir Yang)
Date: Sun, 22 Nov 2015 21:31:17 +0800
Subject: [RFC PATCH v1 0/2] Add basic HDCP function support for dw_hdmi driver
Message-ID: <1448199077-10221-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series try to add the basic HDCP function support for bridge
dw_hdmi driver. Beside this series also resend the patch from Sean
Paul that try to introduce a common way for userspace to operate
the HDCP function.

Userspace could chose to enable/disable the HDCP function throught
the new standard properties "Content Protection", and driver would
reflect the HDCP auth status to "Content Protection KSV" property.

Beside this series also base on Vladimir Zapolskiy's patch that help
to introduce DDC support for dw_hdmi driver.

[Resend] Sean Pual: https://patchwork.kernel.org/patch/7279801
[Rebased on] Vladimir Zapolskiy: https://patchwork.kernel.org/patch/7279801

Thanks
- Yakir



Sean Paul (1):
  drm: Add Content Protection properties to drm

Yakir Yang (1):
  drm: bridgw/dw_hdmi: add basic hdmi hdcp driver

 drivers/gpu/drm/bridge/dw_hdmi.c | 355 ++++++++++++++++++++++++++++++++++++---
 drivers/gpu/drm/bridge/dw_hdmi.h |  20 +++
 drivers/gpu/drm/drm_crtc.c       |  21 +++
 drivers/gpu/drm/drm_sysfs.c      |  46 +++++
 include/drm/bridge/dw_hdmi.h     |  17 ++
 include/drm/drm_crtc.h           |   3 +
 include/uapi/drm/drm_mode.h      |   4 +
 7 files changed, 447 insertions(+), 19 deletions(-)

-- 
1.9.1
