From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 24 Apr 2017 21:01:11 +0800
Subject: [PATCH 0/2] Add ZTE ZX pinctrl driver support
Message-ID: <1493038873-18354-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

This is basically a rewrite of Jun's ZTE ZX pinctrl driver.  It
has quite a few significant changes from Jun's version.

 - It handles the relation between main and auxiliary controllers
   internally, and then we do not need to export core function
   pin_request().
 - Update bindings document with a ASCII figure to illustrate how this
   'hybrid' pin controller hardware works.
 - Rather than making up pin name with the fake port name and pin
   number, name the pins in the exactly same way how hardware manual
   name them.
 - Instead of encoding AON register data, calculate the offset and bit
   position from pin id.
 - Utilize the generic groups and functions support from core to save
   quite some code in our driver.
 - Simplify the data structures and add documents for important ones.
 - Clean up some unnecessary function calls.

Shawn

[1] https://www.spinics.net/lists/linux-gpio/msg16147.html

Shawn Guo (2):
  dt-bindings: add bindings doc for ZTE pinctrl
  pinctrl: add ZTE ZX pinctrl driver support

 .../devicetree/bindings/pinctrl/pinctrl-zx.txt     |   85 ++
 drivers/pinctrl/Kconfig                            |    1 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/zte/Kconfig                        |   13 +
 drivers/pinctrl/zte/Makefile                       |    2 +
 drivers/pinctrl/zte/pinctrl-zx.c                   |  445 +++++++++
 drivers/pinctrl/zte/pinctrl-zx.h                   |  105 ++
 drivers/pinctrl/zte/pinctrl-zx296718.c             | 1027 ++++++++++++++++++++
 8 files changed, 1679 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-zx.txt
 create mode 100644 drivers/pinctrl/zte/Kconfig
 create mode 100644 drivers/pinctrl/zte/Makefile
 create mode 100644 drivers/pinctrl/zte/pinctrl-zx.c
 create mode 100644 drivers/pinctrl/zte/pinctrl-zx.h
 create mode 100644 drivers/pinctrl/zte/pinctrl-zx296718.c

-- 
1.9.1
