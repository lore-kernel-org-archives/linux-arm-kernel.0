From: carlo@caione.org (Carlo Caione)
Date: Sun, 19 Jun 2016 14:38:58 +0200
Subject: [PATCH 0/6] Add Amlogic secure monitor and NVMEM drivers
Message-ID: <1466339944-602-1-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

I decided to respin again the secure monitor driver this time with the NVMEM
driver in the same patchset to have a clear view on how a generic driver can
use the monitor.

The latest patchset for the secure monitor with the Changelog is here [1].

[1] http://www.spinics.net/lists/arm-kernel/msg510441.html

Carlo Caione (6):
  firmware: Amlogic: Add secure monitor driver
  documentation: Add secure monitor bindings documentation
  ARM64: dts: amlogic: gxbb: Enable secure monitor
  nvmem: amlogic: Add Amlogic Meson EFUSE driver
  documentation: Add nvmem bindings documentation
  ARM64: dts: amlogic: gxbb: Enable NVMEM

 .../bindings/firmware/meson/meson_sm.txt           |  15 ++
 .../devicetree/bindings/nvmem/amlogic-efuse.txt    |  39 +++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |  24 ++
 drivers/firmware/Kconfig                           |   1 +
 drivers/firmware/Makefile                          |   1 +
 drivers/firmware/meson/Kconfig                     |   8 +
 drivers/firmware/meson/Makefile                    |   1 +
 drivers/firmware/meson/meson_sm.c                  | 266 +++++++++++++++++++++
 drivers/nvmem/Kconfig                              |  11 +
 drivers/nvmem/Makefile                             |   2 +
 drivers/nvmem/meson-efuse.c                        | 130 ++++++++++
 include/linux/firmware/meson/meson_sm.h            |  32 +++
 12 files changed, 530 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/meson/meson_sm.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt
 create mode 100644 drivers/firmware/meson/Kconfig
 create mode 100644 drivers/firmware/meson/Makefile
 create mode 100644 drivers/firmware/meson/meson_sm.c
 create mode 100644 drivers/nvmem/meson-efuse.c
 create mode 100644 include/linux/firmware/meson/meson_sm.h

-- 
2.7.4
