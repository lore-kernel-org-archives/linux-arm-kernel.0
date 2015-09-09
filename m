From: o.schinagl@ultimaker.com (Olliver Schinagl)
Date: Wed,  9 Sep 2015 11:25:10 +0200
Subject: [PATCH 0/5] Add eeprom to the Olimex series of boards
Message-ID: <1441790715-11957-1-git-send-email-o.schinagl@ultimaker.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some of the olimex series of boards feature a permanently connected eeprom on
i2c-1. This patch series adds them on all the boards that have them according
to the spec-sheets.

I explicitly added my personal --Tested-by to boards I actually tested. There
are two boards, that according to the sheets have them as well and physically
inspecting the boards shows them clearly, I did not actually test them on
those the boards that are missing the --Tested-by. So while it generally
should be safe to merge those patches as well, if someone with those boards
could add a --Tested-by that'd be great.

Additionally, it brings the eeprom on the OLinuXino a10s in line with the rest
and now follows the binding documentation.

Olliver Schinagl (5):
  dts: sunxi: add eeprom to A10 OLinuXino Lime board
  dts: sunxi: correct vendor prefix on OLinuXino a10s micro
  dts: sunxi: add eeprom to A20 OLinuXino Lime board
  dts: sunxi: add eeprom to A20 OLinuXino Lime2 board
  dts: sunxi: add eeprom to A20 OLinuXino micro board

 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts   | 12 ++++++++++++
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts |  2 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts   | 12 ++++++++++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts  |  6 ++++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts  |  6 ++++++
 5 files changed, 37 insertions(+), 1 deletion(-)

-- 
2.1.4
