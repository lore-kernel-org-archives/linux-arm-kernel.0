From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri,  3 Mar 2017 11:14:27 +0100
Subject: [RFC PATCH 1/2] drm/meson: Convert existing documentation to actual
 kerneldoc
In-Reply-To: <1488536068-9407-1-git-send-email-narmstrong@baylibre.com>
References: <1488536068-9407-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1488536068-9407-2-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_canvas.c  |  4 +++-
 drivers/gpu/drm/meson/meson_drv.c     |  5 +++--
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 25 +++++++++++++++++--------
 drivers/gpu/drm/meson/meson_vclk.c    | 22 +++++++++++++++-------
 drivers/gpu/drm/meson/meson_venc.c    | 25 ++++++++++++++++---------
 drivers/gpu/drm/meson/meson_viu.c     |  6 +++++-
 drivers/gpu/drm/meson/meson_vpp.c     |  8 ++++++--
 7 files changed, 65 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_canvas.c b/drivers/gpu/drm/meson/meson_canvas.c
index 4109e36..08f6073 100644
--- a/drivers/gpu/drm/meson/meson_canvas.c
+++ b/drivers/gpu/drm/meson/meson_canvas.c
@@ -24,7 +24,9 @@
 #include "meson_canvas.h"
 #include "meson_registers.h"
 
-/*
+/**
+ * DOC: Canvas
+ *
  * CANVAS is a memory zone where physical memory frames information
  * are stored for the VIU to scanout.
  */
diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index f381088..a3f6b79 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -52,13 +52,14 @@
 #define DRIVER_NAME "meson"
 #define DRIVER_DESC "Amlogic Meson DRM driver"
 
-/*
- * Video Processing Unit
+/**
+ * DOC: Video Processing Unit
  *
  * VPU Handles the Global Video Processing, it includes management of the
  * clocks gates, blocks reset lines and power domains.
  *
  * What is missing :
+ *
  * - Full reset of entire video processing HW blocks
  * - Scaling and setup of the VPU clock
  * - Bus clock gates
diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index 3250140..21f18c3 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -39,18 +39,25 @@
 #define DRIVER_NAME "meson-dw-hdmi"
 #define DRIVER_DESC "Amlogic Meson HDMI-TX DRM driver"
 
-/*
+/**
+ * DOC: HDMI Output
+ *
  * HDMI Output is composed of :
+ *
  * - A Synopsys DesignWare HDMI Controller IP
  * - A TOP control block controlling the Clocks and PHY
  * - A custom HDMI PHY in order convert video to TMDS signal
- *  ___________________________________
- * |            HDMI TOP               |<= HPD
- * |___________________________________|
- * |                  |                |
- * |  Synopsys HDMI   |   HDMI PHY     |=> TMDS
- * |    Controller    |________________|
- * |___________________________________|<=> DDC
+ *
+ * .. code::
+ *
+ *    ___________________________________
+ *   |            HDMI TOP               |<= HPD
+ *   |___________________________________|
+ *   |                  |                |
+ *   |  Synopsys HDMI   |   HDMI PHY     |=> TMDS
+ *   |    Controller    |________________|
+ *   |___________________________________|<=> DDC
+ *
  *
  * The HDMI TOP block only supports HPD sensing.
  * The Synopsys HDMI Controller interrupt is routed
@@ -75,6 +82,7 @@
  * audio source interfaces.
  *
  * We handle the following features :
+ *
  * - HPD Rise & Fall interrupt
  * - HDMI Controller Interrupt
  * - HDMI PHY Init for 480i to 1080p60
@@ -82,6 +90,7 @@
  * - VENC Mode setup for 480i to 1080p60
  *
  * What is missing :
+ *
  * - PHY, Clock and Mode setup for 2k && 4k modes
  * - SDDC Scrambling mode for HDMI 2.0a
  * - HDCP Setup
diff --git a/drivers/gpu/drm/meson/meson_vclk.c b/drivers/gpu/drm/meson/meson_vclk.c
index 45cf1f6..a096571 100644
--- a/drivers/gpu/drm/meson/meson_vclk.c
+++ b/drivers/gpu/drm/meson/meson_vclk.c
@@ -23,21 +23,29 @@
 #include "meson_drv.h"
 #include "meson_vclk.h"
 
-/*
+/**
+ * DOC: Video Clocks
+ *
  * VCLK is the "Pixel Clock" frequency generator from a dedicated PLL.
  * We handle the following encodings :
+ *
  * - CVBS 27MHz generator via the VCLK2 to the VENCI and VDAC blocks
  * - HDMI Pixel Clocks generation
+ *
  * What is missing :
+ *
  * - Genenate Pixel clocks for 2K/4K 10bit formats
  *
  * Clock generator scheme :
- *  __________   _________            _____
- * |          | |         |          |     |--ENCI
- * | HDMI PLL |-| PLL_DIV |--- VCLK--|     |--ENCL
- * |__________| |_________| \        | MUX |--ENCP
- *                           --VCLK2-|     |--VDAC
- *                                   |_____|--HDMI-TX
+ *
+ * .. code::
+ *
+ *    __________   _________            _____
+ *   |          | |         |          |     |--ENCI
+ *   | HDMI PLL |-| PLL_DIV |--- VCLK--|     |--ENCL
+ *   |__________| |_________| \        | MUX |--ENCP
+ *                             --VCLK2-|     |--VDAC
+ *                                     |_____|--HDMI-TX
  *
  * Final clocks can take input for either VCLK or VCLK2, but
  * VCLK is the preferred path for HDMI clocking and VCLK2 is the
diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
index 31dc275..9509017 100644
--- a/drivers/gpu/drm/meson/meson_venc.c
+++ b/drivers/gpu/drm/meson/meson_venc.c
@@ -26,26 +26,33 @@
 #include "meson_vclk.h"
 #include "meson_registers.h"
 
-/*
+/**
+ * DOC: Video Encoder
+ *
  * VENC Handle the pixels encoding to the output formats.
  * We handle the following encodings :
+ *
  * - CVBS Encoding via the ENCI encoder and VDAC digital to analog converter
  * - TMDS/HDMI Encoding via ENCI_DIV and ENCP
  * - Setup of more clock rates for HDMI modes
  *
  * What is missing :
+ *
  * - LCD Panel encoding via ENCL
  * - TV Panel encoding via ENCT
  *
  * VENC paths :
- *        _____   _____   ____________________
- * vd1---|     |-|     | | VENC     /---------|----VDAC
- * vd2---| VIU |-| VPP |-|-----ENCI/-ENCI_DVI-|\
- * osd1--|     |-|     | | \                  | X--HDMI-TX
- * osd2--|_____|-|_____| |  |\-ENCP--ENCP_DVI-|/
- *                       |  |                 |
- *                       |  \--ENCL-----------|----LVDS
- *                       |____________________|
+ *
+ * .. code::
+ *
+ *          _____   _____   ____________________
+ *   vd1---|     |-|     | | VENC     /---------|----VDAC
+ *   vd2---| VIU |-| VPP |-|-----ENCI/-ENCI_DVI-|-|
+ *   osd1--|     |-|     | | \                  | X--HDMI-TX
+ *   osd2--|_____|-|_____| |  |\-ENCP--ENCP_DVI-|-|
+ *                         |  |                 |
+ *                         |  \--ENCL-----------|----LVDS
+ *                         |____________________|
  *
  * The ENCI is designed for PAl or NTSC encoding and can go through the VDAC
  * directly for CVBS encoding or through the ENCI_DVI encoder for HDMI.
diff --git a/drivers/gpu/drm/meson/meson_viu.c b/drivers/gpu/drm/meson/meson_viu.c
index a6de8ba..6bcfa52 100644
--- a/drivers/gpu/drm/meson/meson_viu.c
+++ b/drivers/gpu/drm/meson/meson_viu.c
@@ -28,9 +28,12 @@
 #include "meson_canvas.h"
 #include "meson_registers.h"
 
-/*
+/**
+ * DOC: Video Input Unit
+ *
  * VIU Handles the Pixel scanout and the basic Colorspace conversions
  * We handle the following features :
+ *
  * - OSD1 RGB565/RGB888/xRGB8888 scanout
  * - RGB conversion to x/cb/cr
  * - Progressive or Interlace buffer scanout
@@ -38,6 +41,7 @@
  * - HDR OSD matrix for GXL/GXM
  *
  * What is missing :
+ *
  * - BGR888/xBGR8888/BGRx8888/BGRx8888 modes
  * - YUV4:2:2 Y0CbY1Cr scanout
  * - Conversion to YUV 4:4:4 from 4:2:2 input
diff --git a/drivers/gpu/drm/meson/meson_vpp.c b/drivers/gpu/drm/meson/meson_vpp.c
index 671909d..27356f8 100644
--- a/drivers/gpu/drm/meson/meson_vpp.c
+++ b/drivers/gpu/drm/meson/meson_vpp.c
@@ -25,16 +25,20 @@
 #include "meson_vpp.h"
 #include "meson_registers.h"
 
-/*
+/**
+ * DOC: Video Post Processing
+ *
  * VPP Handles all the Post Processing after the Scanout from the VIU
  * We handle the following post processings :
- * - Postblend : Blends the OSD1 only
+ *
+ * - Postblend, Blends the OSD1 only
  *	We exclude OSD2, VS1, VS1 and Preblend output
  * - Vertical OSD Scaler for OSD1 only, we disable vertical scaler and
  *	use it only for interlace scanout
  * - Intermediate FIFO with default Amlogic values
  *
  * What is missing :
+ *
  * - Preblend for video overlay pre-scaling
  * - OSD2 support for cursor framebuffer
  * - Video pre-scaling before postblend
-- 
1.9.1
