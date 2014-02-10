From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Feb 2014 12:28:03 +0000
Subject: [PATCH RFC v2 00/35] Second preview of imx-drm cleanup series
Message-ID: <20140210122802.GS26684@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the latest revision of my series cleaning up imx-drm and
hopefully getting it ready to be moved out of drivers/staging.
This series is updated to v3.14-rc2.

Since the last round of patches were posted, the component support
has been merged into mainline, and thus dropped from this series.
Greg has taken the first three patches and merged them into his
linux-next tree - however, I include them here for completness.

Most of the comments from last time still apply, and I'll look at
incorporating some of the other patches that were posted in the
coming week.

If I can have some acks for this, I'll start sending some of it to
Greg - I'd like to at least get the five or six initial imx-hdmi
patches to Greg and queued up for the next merge window sooner
rather than later, preferably getting most of this ready for that
window too.

 arch/arm/boot/dts/imx51-babbage.dts        |  10 +-
 arch/arm/boot/dts/imx53-m53evk.dts         |   8 +-
 arch/arm/boot/dts/imx53-mba53.dts          |   6 +
 arch/arm/boot/dts/imx53-qsb.dts            |   8 +-
 arch/arm/boot/dts/imx6dl.dtsi              |   5 +
 arch/arm/boot/dts/imx6q-sabresd.dts        |   4 +
 arch/arm/boot/dts/imx6q.dtsi               |   5 +
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi     |   6 +
 arch/arm/boot/dts/imx6qdl.dtsi             |   9 +
 drivers/staging/imx-drm/Makefile           |   3 +-
 drivers/staging/imx-drm/imx-drm-core.c     | 831 ++++++++++-------------------
 drivers/staging/imx-drm/imx-drm.h          |  39 +-
 drivers/staging/imx-drm/imx-fb.c           |  47 --
 drivers/staging/imx-drm/imx-fbdev.c        |  74 ---
 drivers/staging/imx-drm/imx-hdmi.c         | 680 +++++++++--------------
 drivers/staging/imx-drm/imx-ldb.c          | 125 ++---
 drivers/staging/imx-drm/imx-tve.c          | 134 +++--
 drivers/staging/imx-drm/ipu-v3/ipu-di.c    | 317 +++++------
 drivers/staging/imx-drm/ipuv3-crtc.c       |  56 +-
 drivers/staging/imx-drm/parallel-display.c | 100 ++--
 20 files changed, 934 insertions(+), 1533 deletions(-)
