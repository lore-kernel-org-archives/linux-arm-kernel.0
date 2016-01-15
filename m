From: ykk@rock-chips.com (Yakir Yang)
Date: Fri, 15 Jan 2016 17:36:38 +0800
Subject: [PATCH v3 0/2] Introduce Innosilicon HDMI driver on Rockchip platforms
Message-ID: <1452850598-30859-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Here are a brief introduction to Innosilicon HDMI IP:
 - Support HDMI 1.4a, HDCP 1.2 and DVI 1.0 standard compliant transmitter
 - Support HDMI1.4 a/b 3D function defined in HDMI 1.4 a/b spec
 - Digital video interface supports a pixel size of 24, 30, 36, 48bits color
   depth in RGB
 - S/PDIF output supports PCM, Dolby Digital, DTS digital audio transmission
   (32-192kHz Fs) using IEC60958 and IEC 61937
 - The EDID and CEC function are also supported by Innosilicon HDMI Transmitter
   Controlle

This series is based on Mark's RK3036 VOP series, I have created an test
branch that collected his changes:
[https://github.com/rockchip-linux/kernel/tree/kylin-develop4.4-test]

Best regards,
- Yakir


Changes in v3:
- Use encoder enable/disable function, and remove the encoder DPMS function
- Keep HDMI PLL power on in standby mode

Changes in v2:
- Using DRM atomic helper functions for connector init (Mark)
- Remove "hdmi->connector.encoder = encoder;" (Mark)
- Correct the misspell "rk3036-dw-hdmi" (Heiko)

Yakir Yang (2):
  FORMLIST: drm: rockchip/hdmi: add Innosilicon HDMI support
  dt-bindings: add document for Innosilicon HDMI on Rockchip platform

 .../display/rockchip/inno_hdmi-rockchip.txt        |  50 ++
 drivers/gpu/drm/rockchip/Kconfig                   |   8 +
 drivers/gpu/drm/rockchip/Makefile                  |   1 +
 drivers/gpu/drm/rockchip/inno_hdmi.c               | 999 +++++++++++++++++++++
 drivers/gpu/drm/rockchip/inno_hdmi.h               | 364 ++++++++
 5 files changed, 1422 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/rockchip/inno_hdmi-rockchip.txt
 create mode 100644 drivers/gpu/drm/rockchip/inno_hdmi.c
 create mode 100644 drivers/gpu/drm/rockchip/inno_hdmi.h

-- 
1.9.1
