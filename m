From: carlo@caione.org (Carlo Caione)
Date: Wed, 18 May 2016 16:56:18 +0200
Subject: [PATCH v2 0/4] Add Amlogic secure monitor driver
Message-ID: <1463583382-15614-1-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

In the Amlogic SoCs the secure monitor calls are used for a lot of reasons:
interact with the NVMEM (efuses), check the reboot reason, set USB boot, ...

This driver defines a generic interface towards the secure monitor that can be
used by more specialized drivers to interact with the secure monitor itself
without worrying about bounce buffers managing.

Changelog:

v2:
  * All the SMC function identifiers are now in a SoC-specific header file to
    be included by the DTS files so the SMC commands are now defined in the DT
    instead to be hardcoded into the driver
  * Patchset is no longer an RFC
  * Better error management and boundary checking
  * s/unsigned int/u32/
  * SMC call not only on CPU 0
  * Fix memory leaking
  * s/amlogic/meson/ in the directory names

Carlo Caione (4):
  soc: Amlogic: Add secure monitor driver
  soc: dt-bindings: Add secure monitor header file for GXBB
  ARM64: dts: amlogic: gxbb: Enable secure monitor
  documentation: Add secure monitor binding documentation

 .../devicetree/bindings/soc/meson/meson_sm.txt     |  45 ++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |   7 +
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/meson/Kconfig                          |   8 ++
 drivers/soc/meson/Makefile                         |   1 +
 drivers/soc/meson/meson_sm.c                       | 155 +++++++++++++++++++++
 include/dt-bindings/soc/meson-gxbb-sm.h            |  44 ++++++
 include/linux/soc/meson/meson_sm.h                 |  22 +++
 9 files changed, 284 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/meson/meson_sm.txt
 create mode 100644 drivers/soc/meson/Kconfig
 create mode 100644 drivers/soc/meson/Makefile
 create mode 100644 drivers/soc/meson/meson_sm.c
 create mode 100644 include/dt-bindings/soc/meson-gxbb-sm.h
 create mode 100644 include/linux/soc/meson/meson_sm.h

-- 
2.7.4
