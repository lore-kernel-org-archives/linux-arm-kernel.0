From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Fri,  6 Jul 2018 19:50:56 +0200
Subject: [PATCH 00/17] Allwinner R40 HDMI refactoring
Message-ID: <20180706175113.26698-1-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series fixes several issues found in R40 HDMI patch series after
it was applied. Conversation can be found here:
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/586011.html

One issue raised in that thread is probably not solved (conversation
still on going), but I want to send these patches for review before
I'm going on vacation.

There is also additional DW HDMI driver fix not mentioned in mails.

Patches are based on latest linux-next (next-20180706) and are ordered
in such way that they don't break R40 HDMI at any time. Because of that
I suggest that whole series goes through drm-misc to preserve that order.

I also tested those patches on H3 to make sure it doesn't break other
platforms. However, it would be nice to test for regressions also on
older SoCs (with DE1).

Best regards,
Jernej

Jernej Skrabec (17):
  dt-bindings: display: sun4i-drm: Add R40 display engine compatible
  drm/sun4i: Add R40 display engine compatible
  ARM: dts: sun8i: r40: Remove fallback display engine compatible
  drm/sun4i: tcon-top: Cleanup clock handling
  drm/sun4i: tcon: Release node when traversing of graph
  dt-bindings: display: sun4i-drm: Add R40 TV TCON description
  drm/sun4i: DW HDMI: Release nodes if error happens during CRTC search
  ARM: dts: sun8i: r40: Add mixer ids to TCON TOP
  drm/sun4i: mixer: Read id from DT
  drm/sun4i: tcon-top: Add helpers for switching mux
  drm/sun4i: tcon: Add another way for matching mixers with tcon
  drm/sun4i: tcon: Add support for R40 TCON
  ARM: dts: sun8i: r40: Remove fallback compatible for TCON TV
  ARM: dts: sun8i: r40: Add missing TCON-TOP - TCON connections
  ARM: dts: sun8i: r40: Disable TCONs by default.
  drm/sun4i: tcon-top: Remove mux configuration at probe time
  dt-bindings: display: sun4i-drm: Fix order of DW HDMI PHY compatibles

 .../bindings/display/sunxi/sun4i-drm.txt      |   6 +-
 .../boot/dts/sun8i-r40-bananapi-m2-ultra.dts  |  20 +-
 arch/arm/boot/dts/sun8i-r40.dtsi              |  65 ++++++-
 drivers/gpu/drm/sun4i/sun4i_drv.c             |   1 +
 drivers/gpu/drm/sun4i/sun4i_tcon.c            |  92 ++++++++-
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c         |  15 +-
 drivers/gpu/drm/sun4i/sun8i_mixer.c           |  35 +++-
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c        | 183 ++++++++----------
 drivers/gpu/drm/sun4i/sun8i_tcon_top.h        |   4 +
 9 files changed, 278 insertions(+), 143 deletions(-)

-- 
2.18.0
