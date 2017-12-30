From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Sat, 30 Dec 2017 22:01:52 +0100
Subject: [PATCH 00/11] drm/sun4i: Add A83T HDMI support
Message-ID: <20171230210203.24115-1-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series implements support for A83T DW HDMI and PHY. It is based
upon Maxime Ripard's "drm/sun4i: Add A83t LVDS support" patch series which
can be found here:
http://lists.infradead.org/pipermail/linux-arm-kernel/2017-December/550035.html

While exactly this combination of HDMI controller and PHY is not common in
Allwinner SoCs, this patch series nevertheless makes groundwork for other
SoCs, which have same DW HDMI IP block, but different PHYs, like H3 and H5.

All patches can also be found on github:
https://github.com/jernejsk/linux-1/commits/a83t_hdmi

Please take a look.

Best regards,
Jernej

Jernej Skrabec (11):
  clk: sunxi-ng: Don't set k if width is 0 for nkmp plls
  clk: sunxi-ng: a83t: Add M divider to TCON1 clock
  drm/bridge/synopsys: dw-hdmi: Enable workaround for v1.32a
  drm/bridge/synopsys: dw-hdmi: Export some PHY related functions
  drm/bridge/synopsys: dw-hdmi: Add deinit callback
  dt-bindings: display: sun4i-drm: Add A83T HDMI pipeline
  drm/sun4i: Add support for A83T second TCON
  drm/sun4i: Add support for A83T second DE2 mixer
  drm/sun4i: Implement A83T HDMI driver
  ARM: dts: sun8i: a83t: Add HDMI display pipeline
  ARM: dts: sun8i: a83t: Enable HDMI on BananaPi M3

 .../bindings/display/sunxi/sun4i-drm.txt           | 188 ++++++++++-
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts       |  29 ++
 arch/arm/boot/dts/sun8i-a83t.dtsi                  | 108 +++++-
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c              |   4 +-
 drivers/clk/sunxi-ng/ccu_nkmp.c                    |  21 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |  56 +++-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.h          |   2 +
 drivers/gpu/drm/sun4i/Kconfig                      |   9 +
 drivers/gpu/drm/sun4i/Makefile                     |   1 +
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |  46 ++-
 drivers/gpu/drm/sun4i/sun4i_tcon.h                 |   1 +
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c              | 367 +++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun8i_mixer.c                |  11 +
 include/drm/bridge/dw_hdmi.h                       |  11 +
 14 files changed, 808 insertions(+), 46 deletions(-)
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c

-- 
2.15.1
