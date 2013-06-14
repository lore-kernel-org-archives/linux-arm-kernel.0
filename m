From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Fri, 14 Jun 2013 17:41:45 +0200
Subject: [PATCH 0/5] pinctrl: fix some issues with new pinconfig dt parsing
Message-ID: <201306141741.46077.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some issues with the recently submitted generic pinconfig parsing from dt
came up, so fix these in this follow-up series.

Hopefully I did catch all of them.

Tested on my rk3066 device.

Heiko Stuebner (5):
  pinctrl: update the documentation for some pinconfig params
  pinctrl: clarify some dt pinconfig options
  pinctrl: handle zero found dt pinconfig properties better
  pinctrl: dynamically alloc temp array when parsing dt pinconf options
  pinctrl: rockchip: correctly handle arguments of pinconf options

 .../bindings/pinctrl/pinctrl-bindings.txt          |   22 +++++++++++-
 drivers/pinctrl/pinconf-generic.c                  |   38 +++++++++++++++-----
 drivers/pinctrl/pinctrl-rockchip.c                 |   37 ++++++++++++++++---
 include/linux/pinctrl/pinconf-generic.h            |   18 ++++++----
 4 files changed, 93 insertions(+), 22 deletions(-)

-- 
1.7.10.4
