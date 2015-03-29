From: carlo@caione.org (Carlo Caione)
Date: Sun, 29 Mar 2015 12:56:39 +0200
Subject: [PATCH v4 0/3] Amlogic Meson8b pinctrl driver support
Message-ID: <1427626602-9656-1-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

This patchset extends the pinctrl driver to support AmLogic Meson8b.
The driver for Meson8 has been revised to make it shorter.

Changelog:

v4: * Add ACKs
    * Fix overlapping GPIO numbers for the DIF_* pins
v3: * shorten the meson8/meson8b support files
    * document GPIO banks for meson8b
v2: * fix holes in GPIOs numbering
v1: * initial version

Carlo Caione (3):
  pinctrl: Cleanup Meson8 driver
  documentation: Extend pinctrl docs for Meson8b
  pinctrl: Add support for Meson8b

 .../devicetree/bindings/pinctrl/meson,pinctrl.txt  |    2 +-
 drivers/pinctrl/meson/Makefile                     |    2 +-
 drivers/pinctrl/meson/pinctrl-meson.c              |    9 +-
 drivers/pinctrl/meson/pinctrl-meson.h              |    9 +-
 drivers/pinctrl/meson/pinctrl-meson8.c             | 1050 +++++++++-----------
 drivers/pinctrl/meson/pinctrl-meson8b.c            |  899 +++++++++++++++++
 include/dt-bindings/gpio/meson8b-gpio.h            |   32 +
 7 files changed, 1402 insertions(+), 601 deletions(-)
 create mode 100644 drivers/pinctrl/meson/pinctrl-meson8b.c
 create mode 100644 include/dt-bindings/gpio/meson8b-gpio.h

-- 
1.9.1
