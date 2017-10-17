From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 17 Oct 2017 10:07:40 +0200
Subject: [PATCH 0/4] drm/meson: power domain init related fixes
Message-ID: <1508227664-11171-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the Amlogic Gx SoCs (GXBB, GXL & GXM), the VPU power domain is initialized
by the vendor U-Boot code, but running mainline U-boot has been possible
on these SoCs. But lacking such init made the system lock at kernel boot.

A PM Power Domain driver has been pushed at [1] to solve the main issue.
The following patches :
- updates the DT bindings accordingly
- adds support for missing regulators and registers init

Neil Armstrong (4):
  dt-bindings: display: amlogic,meson-vpu: Add optional power domain
    property
  dt-bindings: display: amlogic,meson-dw-hdmi: Add optional HDMI 5V
    regulator
  drm/meson: dw_hdmi: Add support for an optional external 5V regulator
  drm/meson: Add missing VPU init

 .../devicetree/bindings/display/amlogic,meson-dw-hdmi.txt   |  4 ++++
 .../devicetree/bindings/display/amlogic,meson-vpu.txt       |  4 ++++
 drivers/gpu/drm/meson/meson_drv.c                           |  9 +++++++++
 drivers/gpu/drm/meson/meson_dw_hdmi.c                       | 13 +++++++++++++
 drivers/gpu/drm/meson/meson_registers.h                     |  4 ++++
 5 files changed, 34 insertions(+)

-- 
2.7.4
