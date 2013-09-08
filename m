From: pali.rohar@gmail.com (=?UTF-8?q?Pali=20Roh=C3=A1r?=)
Date: Sun,  8 Sep 2013 10:50:35 +0200
Subject: [PATCH 0/4] Add support for charging battery in Nokia RX-51
Message-ID: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series finally bringing support for charging battery on
Nokia N900 (RX-51) without any proprietary Nokia bits in userspace.

Pali Roh?r (4):
  usb: musb: Call atomic_notifier_call_chain when status is changed
  power: isp1704_charger: Fix driver to work with changes introduced in
    v3.5
  power: isp1704_charger: Add callback function set_current
  RX-51: Add platform function and data for bq24150a charger

 arch/arm/mach-omap2/board-rx51-peripherals.c |   56 +++++++++++++-
 drivers/power/isp1704_charger.c              |  107 ++++++++++++++------------
 drivers/usb/musb/omap2430.c                  |    3 +
 drivers/usb/phy/phy-twl4030-usb.c            |    2 +
 include/linux/power/isp1704_charger.h        |    1 +
 5 files changed, 117 insertions(+), 52 deletions(-)

-- 
1.7.10.4
