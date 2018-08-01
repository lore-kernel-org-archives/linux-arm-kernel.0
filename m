From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed,  1 Aug 2018 12:00:18 +0200
Subject: [PATCH 0/5] pinctrl: meson: Add support for TEST_N gpio
Message-ID: <1533117623-27856-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Amlogic Meson GX and AXG SoCs needs to do a Secure Monitor call to
set the TEST_N pin direction.
This patchset :
- adds the Secure Monitor call
- adds support int the pinctrl-meson common code
- adds support for GXBB, GXL and AGX SoCs

Neil Armstrong (5):
  meson_sm: add TEST_N pin direction call
  pinctrl: meson: Add support to set direction with a secure monitor
    call
  meson: pinctrl-gxbb: add support for TEST_N pin
  meson: pinctrl-gxl: add support for TEST_N pin
  meson: pinctrl-axg: add support for TEST_N pin

 drivers/firmware/meson/meson_sm.c          |  1 +
 drivers/pinctrl/meson/Kconfig              |  1 +
 drivers/pinctrl/meson/pinctrl-meson-axg.c  |  4 ++++
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c |  4 ++++
 drivers/pinctrl/meson/pinctrl-meson-gxl.c  |  4 ++++
 drivers/pinctrl/meson/pinctrl-meson.c      | 31 +++++++++++++++++++++++++-----
 drivers/pinctrl/meson/pinctrl-meson.h      | 10 +++++++++-
 include/linux/firmware/meson/meson_sm.h    |  1 +
 8 files changed, 50 insertions(+), 6 deletions(-)

-- 
2.7.4
