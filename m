From: dianders@chromium.org (Doug Anderson)
Date: Thu, 28 Aug 2014 12:36:03 -0700
Subject: [PATCH 0/2] IO voltage domain support for rk3188 and rk3288
Message-ID: <1409254565-10677-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These two patches add support for automatically configuring the IO
voltage domains on rk3188 and rk3288 SoCs.  The first patch adds some
new notification types to the regulator code.  It's used by the second
patch which actually implements the IO voltage domain driver.

These two patches were co-developed by Heiko St?bner and Doug Anderson
(proof of concept patches were written by Heiko).  They were tested in
a private branch on an rk3288 board using rk808 instead of mainline
since rk808 support isn't finalized in mainline yet.

(sorry if you got this series twice; my mailer seems unhappy with me)

Heiko St?bner (2):
  regulator: core: Add REGULATOR_EVENT_PRE_VOLTAGE_CHANGE (and ABORT)
  soc/rockchip: io-domain: add driver handling io domains

 .../devicetree/bindings/arm/rockchip/io-domain.txt |  60 ++++
 drivers/regulator/core.c                           |  63 +++-
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/rockchip/Kconfig                       |  10 +
 drivers/soc/rockchip/Makefile                      |   1 +
 drivers/soc/rockchip/io-domain.c                   | 333 +++++++++++++++++++++
 include/linux/regulator/consumer.h                 |  20 ++
 8 files changed, 482 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/rockchip/io-domain.txt
 create mode 100644 drivers/soc/rockchip/Kconfig
 create mode 100644 drivers/soc/rockchip/Makefile
 create mode 100644 drivers/soc/rockchip/io-domain.c

-- 
2.1.0.rc2.206.gedb03e5
