From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Sun, 9 Jun 2013 01:59:05 +0200
Subject: [PATCH 0/2] pinctrl: common handling of generic pinconfig props in dt
Message-ID: <201306090159.05383.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

following your suggestions for a common handling of things like pulls in dt,
I've come up with the following solution - hopefully I've gotten the correct
meaning of your explanaitions.

It handles all the pinconfigs that either ignore the argument, or have very
simple one, like PIN_CONFIG_OUTPUT does.

I've also attached my current rockchip pinctrl driver to show how it is using
this currently.


Heiko Stuebner (2):
  pinctrl: add devicetree constants for simple generic pnconfig options
  pinctrl: add function to separate combined pinconfig values

 .../bindings/pinctrl/pinctrl-bindings.txt          |    9 +++
 drivers/pinctrl/pinconf-generic.c                  |   61 ++++++++++++++++++++
 drivers/pinctrl/pinconf.h                          |    6 ++
 include/dt-bindings/pinctrl/pinconfig.h            |   37 ++++++++++++
 4 files changed, 113 insertions(+), 0 deletions(-)
 create mode 100644 include/dt-bindings/pinctrl/pinconfig.h

-- 
1.7.2.3
