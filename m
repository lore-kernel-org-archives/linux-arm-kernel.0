From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 06 Jul 2014 20:42:16 +0200
Subject: [RFC PATCH 0/3] ARM: restart-notifier support for some architectures
Message-ID: <1531376.ijR0PPyvmJ@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series provides restart-notifier integration for the architectures
I care about - S3C24XX and Rockchip.

It of course depends on "kernel: Add support for restart notifier call chain"
from Guenter Roeck.

Samsung machines can generally be reset using their watchdog, but some
also provide a special software-reset register in their system controller.

The rockchip reset integration of course also depends on the core clock
support series, currently still under review.


Heiko Stuebner (3):
  watchdog: s3c2410: add restart notifier
  clk: samsung: register restart notifiers for s3c2412 and s3c2443
  clk: rockchip: add restart notifier

 drivers/clk/rockchip/clk-rk3188.c |  2 ++
 drivers/clk/rockchip/clk-rk3288.c |  2 ++
 drivers/clk/rockchip/clk.c        | 23 +++++++++++++++++++++++
 drivers/clk/rockchip/clk.h        |  1 +
 drivers/clk/samsung/clk-s3c2412.c | 28 ++++++++++++++++++++++++++++
 drivers/clk/samsung/clk-s3c2443.c | 18 ++++++++++++++++++
 drivers/watchdog/s3c2410_wdt.c    | 33 +++++++++++++++++++++++++++++++++
 7 files changed, 107 insertions(+)

-- 
1.9.0
