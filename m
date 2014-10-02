From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  2 Oct 2014 10:40:13 +0200
Subject: [PATCH 0/7] pinctrl: force-convert to generic DT bindings
Message-ID: <1412239220-22495-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've had it with custom "foo,function" and "foo,groups", "foo,pins"
etc custom bindings for pin control.

Yes, I know we could not agree in the past on some generic bindings
and no, the older systems will not be converted if they are in
deployment.

But I *know* the nomadik pin controllers does not have deployed
device trees in the wild, so I will just convert them to use the
standard bindings I just posted in other patches, using simple names
like "function", "groups", "pins" etc.

After this atleast the abx500 pin controller is phased over to
use the generic bindings and can be held up as an example. I will
also move the code parsing the bindings into the core, so that any
pin controller using this can rely on that code and we do not
need to invent more crazy parsers all over the place.

Linus Walleij (7):
  pinctrl: nomadik: force-convert to generic mux bindings
  pinctrl: abx500: force-convert to generic mux bindings
  pinctrl: nomadik: force-convert to generic config bindings
  pinctrl: abx500: force-convert to generic config bindings
  pinctrl: abx500: retire phandle config mechanism
  pinctrl: abx500: update device tree bindings
  pinctrl: abx500: mark pin config as generic

 .../devicetree/bindings/pinctrl/ste,abx500.txt     | 184 +++++++----------
 arch/arm/boot/dts/ste-ccu8540-pinctrl.dtsi         |  64 +++---
 arch/arm/boot/dts/ste-href-ab8500.dtsi             | 162 +++++++--------
 arch/arm/boot/dts/ste-href-ab8505.dtsi             |  90 ++++----
 arch/arm/boot/dts/ste-href-family-pinctrl.dtsi     | 230 ++++++++++-----------
 arch/arm/boot/dts/ste-href-stuib.dtsi              |   4 +-
 arch/arm/boot/dts/ste-href-tvk1281618.dtsi         |  12 +-
 arch/arm/boot/dts/ste-hrefprev60.dtsi              |  20 +-
 arch/arm/boot/dts/ste-hrefv60plus.dtsi             |  42 ++--
 arch/arm/boot/dts/ste-nomadik-s8815.dts            |   8 +-
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi         |  32 +--
 arch/arm/boot/dts/ste-snowball.dts                 |  36 ++--
 drivers/pinctrl/nomadik/pinctrl-abx500.c           |  33 ++-
 drivers/pinctrl/nomadik/pinctrl-nomadik.c          |  18 +-
 14 files changed, 449 insertions(+), 486 deletions(-)

-- 
1.9.3
