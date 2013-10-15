From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 15 Oct 2013 12:46:49 +0200
Subject: [PATCH 0/6] pinctrl: rockchip: add rk3188 support
Message-ID: <201310151246.49402.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A patch series, finalizing support for the pin controller in the  rk3188.

As mentioned in the individual patches, the rk3188 makes it even more
complex due to its strange pull setting configuration. Therefore a bit
of reordering needed to take place to accomodate this.

Heiko Stuebner (6):
  pinctrl: rockchip: separate different sub-types more
  of: add function to check against a list of compatible strings
  pinctrl: rockchip: add support for multiple bank types
  pinctrl: rockchip: remove redundant check
  pinctrl: rockchip: add rk3188 specifics
  pinctrl: rockchip: emulate both edge triggered interrupts

 .../bindings/pinctrl/rockchip,pinctrl.txt          |   46 +++-
 drivers/of/base.c                                  |   21 ++
 drivers/pinctrl/pinctrl-rockchip.c                 |  290 +++++++++++++++-----
 include/linux/of.h                                 |    2 +
 4 files changed, 295 insertions(+), 64 deletions(-)

-- 
1.7.10.4
