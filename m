From: maxi.jourdan@wanadoo.fr (Maxime Jourdan)
Date: Tue, 24 Apr 2018 20:48:36 +0200
Subject: [PATCH v2 0/2] clk: meson: gxbb: add the video decoder clocks
Message-ID: <20180424184838.3406-1-maxi.jourdan@wanadoo.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the necessary clocks for VDEC_1 and VDEC_HEVC.

On Amlogic SoCs, VDEC1 is responsible for the decoding of:
MPEG 1/2/4, H.263, H.264, MJPEG, VC1, Real Video

VDEC_HEVC is responsible for the decoding of:
HEVC, VP9

Changes since v1:
 - Drop CLK_IGNORE_UNUSED flags
 - Change CLK_SET_RATE_NO_REPARENT to CLK_SET_RATE_PARENT for muxes
 - Add CLK_MUX_ROUND_CLOSEST for muxes

Maxime Jourdan (2):
  clk: meson: gxbb: expose VDEC_1 and VDEC_HEVC clocks
  clk: meson: gxbb: add the video decoder clocks

 drivers/clk/meson/gxbb.c              | 114 ++++++++++++++++++++++++++
 drivers/clk/meson/gxbb.h              |   6 +-
 include/dt-bindings/clock/gxbb-clkc.h |   2 +
 3 files changed, 121 insertions(+), 1 deletion(-)

-- 
2.17.0
