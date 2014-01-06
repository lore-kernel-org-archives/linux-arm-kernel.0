From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon,  6 Jan 2014 15:51:59 +0100
Subject: [RFC PATCH 0/3] imx-drm dt bindings
Message-ID: <1389019922-31992-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

these patches apply on top of Russell's imx-drm cleanup preview
series. I have added device tree bindings between IPU and the
encoders as documented in
Documentation/devicetree/bindings/media/video-interfaces.txt
and used those to determine the possible_crtcs and mux_id.

The crtc cookie is replaced with a the port device tree node,
which is unique and therefore allows to get rid of the di_id
comparison. Storing the multiplexer input numbers in the device
tree removes the need to know the ipu_id. This should also allow
to replace IPU2 with LCDIF on i.MX6 Solo more easily.

regards
Philipp

Philipp Zabel (3):
  ARM: dts: imx6qdl: Add ports and endpoints to IPU DIs
  staging: imx-drm-core: Use graph to find connection between crtc and
    encoder
  staging: imx-drm-core: associate crtc devices with di port nodes

 arch/arm/boot/dts/imx6q.dtsi           | 115 +++++++++++++++++++++++++++--
 arch/arm/boot/dts/imx6qdl.dtsi         | 127 ++++++++++++++++++++++++++++++++-
 drivers/staging/imx-drm/imx-drm-core.c |  82 ++++++++++++++-------
 drivers/staging/imx-drm/imx-drm.h      |   4 +-
 drivers/staging/imx-drm/imx-hdmi.c     |   2 +-
 drivers/staging/imx-drm/imx-ldb.c      |   4 +-
 drivers/staging/imx-drm/ipuv3-crtc.c   |  36 +++++++++-
 7 files changed, 328 insertions(+), 42 deletions(-)

-- 
1.8.5.2
