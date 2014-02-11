From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 11 Feb 2014 12:45:40 +0100
Subject: [RFC PATCH v2 0/4] imx-drm dt bindings
Message-ID: <1392119144-27868-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

these patches apply on top of Russell's second preview of the
imx-drm cleanup series. I have added device tree bindings between
IPU and the encoders as documented in
Documentation/devicetree/bindings/media/video-interfaces.txt
and used those to determine the possible_crtcs and mux_id.

The crtc cookie is replaced with a the port device tree node,
which is unique and therefore allows to get rid of the di_id
comparison. Storing the multiplexer input numbers in the device
tree removes the need to know the ipu_id. This should also allow
to replace IPU2 with LCDIF on i.MX6 Solo more easily.

In v2 I've added temporary copies of the v4l2_of helpers to imx-drm
and tested it on the SolidRun Hummingboard.

regards
Philipp


Philipp Zabel (4):
  staging: imx-drm: Add temporary copies of v4l2-of parsing functions
  staging: imx-drm-core: Use graph to find connection between crtc and
    encoder
  staging: imx-drm-core: associate crtc devices with di port nodes
  ARM: dts: imx6qdl: Add ports and endpoints to IPU DIs

 arch/arm/boot/dts/imx6dl.dtsi          |   9 +--
 arch/arm/boot/dts/imx6q.dtsi           | 115 +++++++++++++++++++++++++--
 arch/arm/boot/dts/imx6qdl.dtsi         | 137 ++++++++++++++++++++++++++++++++-
 drivers/staging/imx-drm/Makefile       |   2 +-
 drivers/staging/imx-drm/imx-drm-core.c |  82 +++++++++++++-------
 drivers/staging/imx-drm/imx-drm-of.c   | 106 +++++++++++++++++++++++++
 drivers/staging/imx-drm/imx-drm.h      |   9 ++-
 drivers/staging/imx-drm/imx-hdmi.c     |   2 +-
 drivers/staging/imx-drm/imx-ldb.c      |   4 +-
 drivers/staging/imx-drm/ipuv3-crtc.c   |  39 +++++++++-
 10 files changed, 453 insertions(+), 52 deletions(-)
 create mode 100644 drivers/staging/imx-drm/imx-drm-of.c

-- 
1.8.5.3
