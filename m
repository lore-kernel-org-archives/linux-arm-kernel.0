From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 27 Feb 2015 13:24:41 +0100
Subject: [PATCH v2 0/4] Add proper support for Compulab CM-A510/SBC-A510
In-Reply-To: <1424199129-22099-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1424199129-22099-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1425039885-5137-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is v2 of the patch set to improve current mainline support for the
Compulab CM-A510 System-on-Module (SoM) and its default Compulab SBC-A510
base board. 

Compared to v1 there have been the following changes:
- removed preparing Dove patches that already have been taken by MVEBU
  maintainers.
- added a Tested-by for i2c-mux-pinctrl changes from Stepen Warren.
- reworded i2c-mux-pinctrl devicetree doc changes
  (Suggested by Stephen Warren).
- Added an Acked-by for the vendor-prefix patch from Rob Herring.
- Added an Acked-by for the addition of i2c mux node to dove.dtsi from
  Gregory Clement.
- Rebased on top of v4.0-rc1 with preparing patches applied.

Patches are based on v4.0-rc1 with preparing patches for Dove applied
and are intended for v4.1.

Sebastian Hesselbarth (4):
  i2c: mux-pinctrl: Rework to honor disabled child nodes
  devicetree: vendor-prefixes: Add CompuLab to known vendors
  ARM: dts: dove: Add internal i2c multiplexer node
  ARM: dts: dove: Add proper support for Compulab CM-A510/SBC-A510

 .../devicetree/bindings/i2c/i2c-mux-pinctrl.txt    |  25 +--
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   4 +-
 arch/arm/boot/dts/dove-cm-a510.dts                 |  38 ----
 arch/arm/boot/dts/dove-cm-a510.dtsi                | 195 +++++++++++++++++++++
 arch/arm/boot/dts/dove-sbc-a510.dts                | 182 +++++++++++++++++++
 arch/arm/boot/dts/dove.dtsi                        |  40 ++++-
 drivers/i2c/muxes/i2c-mux-pinctrl.c                |  70 +++++---
 8 files changed, 477 insertions(+), 78 deletions(-)
 delete mode 100644 arch/arm/boot/dts/dove-cm-a510.dts
 create mode 100644 arch/arm/boot/dts/dove-cm-a510.dtsi
 create mode 100644 arch/arm/boot/dts/dove-sbc-a510.dts

---
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Gabriel Dobato <dobatog@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-i2c at vger.kernel.org
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
-- 
2.1.0
