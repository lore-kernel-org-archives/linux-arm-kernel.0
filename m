From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sat,  3 Mar 2012 12:40:00 +0100
Subject: [PATCH] Add helper for registering a fixed regulator
Message-ID: <1330774804-7310-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

The following adds a helper for registering a fixed dummy regulator
making it simple for boards which have no software controllable regulator
for certain devices to register a fixed regulator as a dummy.

The last two patches make smsc911x ethernet functional again which
broke when the smsc911x driver gained regulator support.

Sascha

----------------------------------------------------------------
Sascha Hauer (4):
      regulator fixed: Do not report enumaratable voltages if there are none
      regulator: provide a helper for registering a fixed regulator
      ARM i.MX pcm037: register a dummy regulator for the smsc911x device
      ARM i.MX 3ds debugboard: register a dummy regulator for the smsc911x device

 arch/arm/mach-imx/mach-pcm037.c    |    9 ++++++
 arch/arm/plat-mxc/3ds_debugboard.c |    9 ++++++
 drivers/regulator/Makefile         |    2 +-
 drivers/regulator/fixed-helper.c   |   53 ++++++++++++++++++++++++++++++++++++
 drivers/regulator/fixed.c          |    4 ++-
 include/linux/regulator/fixed.h    |   13 +++++++++
 6 files changed, 88 insertions(+), 2 deletions(-)
 create mode 100644 drivers/regulator/fixed-helper.c
