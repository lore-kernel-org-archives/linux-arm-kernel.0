From: stefan@agner.ch (Stefan Agner)
Date: Wed, 12 Sep 2018 11:32:14 -0700
Subject: [PATCH v2 0/8] drm/bridge: add bus flag support
Message-ID: <20180912183222.25414-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This v2 shifted a bit more to rework bridge timing support. While
my use case mainly cares about complete bus flag support, it seems
to me that bus timings have ended up to be more complex than
necessary. Patch 2/3 are an attempt to simplify bus timings. This
also aligns bridge timings with how display timings are specified
today.

@Linus Walleij, Laurent Pinchart: Since you have been involved in
the initial bus timings discussion, I would like to have your Ack
on at least patch 2/3... If we want to keep the setup/hold timings,
the patchset should also work without those two patches.

--
Stefan

Changes in v2:
- Rename bus_flags to simple_bus_flags
- Reword dt-bindings for de-active
- Add patch 2/3 which attempts to simplify bridge timings

Stefan Agner (8):
  drm/bridge: use bus flags in bridge timings
  drm/pl111: simplify bridge timing support
  drm/bridge: simplify bridge timing info
  drm/bridge: allow to specify data-enable polarity
  dt-bindings: display: add data-enable polarity property
  drm/imx: support handling bridge timings bus flags
  ARM: dts: imx6qdl-apalis: add VGA support
  ARM: dts: imx6qdl-apalis: add GPIO I2C node for DDC

 .../bindings/display/bridge/dumb-vga-dac.txt  |  2 +
 arch/arm/boot/dts/imx6q-apalis-eval.dts       | 28 ++++++++
 arch/arm/boot/dts/imx6qdl-apalis.dtsi         | 72 +++++++++++++++++++
 drivers/gpu/drm/bridge/dumb-vga-dac.c         | 45 +++++++-----
 drivers/gpu/drm/imx/parallel-display.c        |  3 +
 drivers/gpu/drm/pl111/pl111_display.c         | 22 ++----
 include/drm/drm_bridge.h                      | 25 ++-----
 7 files changed, 142 insertions(+), 55 deletions(-)

-- 
2.18.0
