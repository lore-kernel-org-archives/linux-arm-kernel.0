From: rmk@arm.linux.org.uk (Russell King)
Date: Mon, 24 Feb 2014 14:20:20 +0000
Subject: [GIT PULL] imx-drm conversion to component support
Message-ID: <20140224142019.GA15820@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg,

Please incorporate the latest imx-drm updates into staging, which can be
found at:

  git://ftp.arm.linux.org.uk/~rmk/linux-arm.git imx-drm-staging

with SHA1 d94905e019acce960feeda1f92a9427fbe45ebbe.

These changes, which convert imx-drm to use the recently merged component
infrastructure, have been reviewed and acked by Philipp Zabel, Shawn Guo
and Fabio Estevam, and are now deemed to be ready.

This will update the following files:

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
 drivers/staging/imx-drm/imx-drm-core.c     | 796 ++++++++++-------------------
 drivers/staging/imx-drm/imx-drm.h          |  39 +-
 drivers/staging/imx-drm/imx-fb.c           |  47 --
 drivers/staging/imx-drm/imx-fbdev.c        |  74 ---
 drivers/staging/imx-drm/imx-hdmi.c         | 663 ++++++++++--------------
 drivers/staging/imx-drm/imx-ldb.c          | 125 ++---
 drivers/staging/imx-drm/imx-tve.c          | 134 +++--
 drivers/staging/imx-drm/ipu-v3/ipu-di.c    | 317 +++++-------
 drivers/staging/imx-drm/ipuv3-crtc.c       |  56 +-
 drivers/staging/imx-drm/parallel-display.c | 100 ++--
 20 files changed, 918 insertions(+), 1497 deletions(-)
 delete mode 100644 drivers/staging/imx-drm/imx-fb.c
 delete mode 100644 drivers/staging/imx-drm/imx-fbdev.c

through these changes:

Russell King (29):
      imx-drm: imx-hdmi: convert HDMI clock settings to tabular form
      imx-drm: imx-hdmi: clean up setting CSC registers
      imx-drm: imx-hdmi: provide register modification function
      imx-drm: imx-hdmi: clean up setting of vp_conf
      imx-drm: imx-hdmi: fix CTS/N setup at init time
      imx-drm: ipu-v3: more inteligent DI clock selection
      imx-drm: ipu-v3: don't use clk_round_rate() before clk_set_rate()
      imx-drm: ipu-v3: more clocking fixes
      imx-drm: add imx6 DT configuration for HDMI
      imx-drm: update and fix imx6 DT descriptions for v3 HDMI driver
      imx-drm: imx-drm-core: sanitise imx_drm_encoder_get_mux_id()
      imx-drm: imx-drm-core: use array instead of list for CRTCs
      imx-drm: provide common connector mode validation function
      imx-drm: simplify setup of panel format
      imx-drm: convert to componentised device support
      imx-drm: delay publishing sysfs connector entries
      imx-drm: remove separate imx-fbdev
      imx-drm: remove imx-fb.c
      imx-drm: use supplied drm_device where possible
      imx-drm: imx-drm-core: provide helper function to parse possible crtcs
      imx-drm: imx-drm-core: provide common connector and encoder cleanup functions
      imx-drm: initialise drm components directly
      imx-drm: imx-drm-core: remove imx_drm_connector and imx_drm_encoder code
      imx-drm: imx-drm-core: get rid of drm_mode_group_init_legacy_group()
      imx-drm: imx-drm-core: kill off mutex
      imx-drm: imx-drm-core: move allocation of imxdrm device to driver load function
      imx-drm: imx-drm-core: various cleanups
      imx-drm: imx-drm-core: add core hotplug connector support
      imx-drm: imx-hdmi: add hotplug support to HDMI component

Thanks.
