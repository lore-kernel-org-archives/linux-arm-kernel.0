From: ykk@rock-chips.com (Yakir Yang)
Date: Mon, 25 Jan 2016 09:43:17 +0800
Subject: [PATCH v6 0/1] Introduce Innosilicon HDMI driver on Rockchip platforms
Message-ID: <1453686197-20975-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Here are a brief introduction to Innosilicon HDMI IP:
  - Support HDMI 1.4a, HDCP 1.2 and DVI 1.0 standard compliant transmitter
  - Support HDMI1.4 a/b 3D function defined in HDMI 1.4 a/b spec
  - Digital video interface supports a pixel size of 24, 30, 36, 48bits color depth in RGB
  - S/PDIF output supports PCM, Dolby Digital, DTS digital audio transmission
    (32-192kHz Fs) using IEC60958 and IEC 61937
  - The EDID and CEC function are also supported by Innosilicon HDMI Transmitter Controlle


Changes in v6:
- Rebase the Makefile/Kconfig files which add by Chris's rockchip-mipi driver (Caeser)

Changes in v5:
- Use hdmi_infoframe helper functions to packed the infoframe (Russell)
- Remove the unused double wait_for_completion_timeout for ddc transfer (Russell)
- Remove the unused local variable in "inno_hdmi_i2c_write()" function (Russell)

Changes in v4:
- Modify the commit title "drm/rockchip: hdmi: ..." (Mark)
- Correct the "DKMS" to "DPMS" (Mark)
- Fix over 80 characters problems (Mark)
- Remove encoder .prepare/.commit helper functions, and move the vop mode
configure function into encoder .enable helper functions. (Mark)

Changes in v3:
- Use encoder enable/disable function, and remove the encoder DPMS function
- Keep HDMI PLL power on in standby mode

Changes in v2:
- Using DRM atomic helper functions for connector init (Mark)
    - Remove "hdmi->connector.encoder = encoder;" (Mark)

Yakir Yang (1):
  drm/rockchip: hdmi: add Innosilicon HDMI support

 drivers/gpu/drm/rockchip/Kconfig     |   8 +
 drivers/gpu/drm/rockchip/Makefile    |   1 +
 drivers/gpu/drm/rockchip/inno_hdmi.c | 941 +++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/rockchip/inno_hdmi.h | 362 ++++++++++++++
 4 files changed, 1312 insertions(+)
 create mode 100644 drivers/gpu/drm/rockchip/inno_hdmi.c
 create mode 100644 drivers/gpu/drm/rockchip/inno_hdmi.h

-- 
1.9.1
