From: sre@debian.org (Sebastian Reichel)
Date: Tue, 22 Oct 2013 14:47:19 +0200
Subject: [PATCHv2 0/3] Add Nokia N900 DT support
Message-ID: <1382446042-27099-1-git-send-email-sre@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree support for the Nokia N900 keyboard.

Changes since v1:
 * create "DTS: ARM: TWL4030: Add keypad node" patch, which
   was part of "Input: twl4030-keypad - add device tree support"
   before.
 * use "IS_ENABLED(CONFIG_OF)" to check if DT is enabled

Currently non-DT boot crashes for me very early, so I was not able
to check this patch using non-DT boot.

-- Sebastian

Sebastian Reichel (3):
  Input: twl4030-keypad - add device tree support
  DTS: ARM: TWL4030: Add keypad node
  ARM: dts: N900: TWL4030 Keypad Matrix definition

 .../devicetree/bindings/input/twl4030-keypad.txt   | 31 ++++++++
 arch/arm/boot/dts/omap3-n900.dts                   | 55 +++++++++++++
 arch/arm/boot/dts/twl4030.dtsi                     |  7 ++
 drivers/input/keyboard/twl4030_keypad.c            | 91 ++++++++++++++++++----
 4 files changed, 167 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/twl4030-keypad.txt

-- 
1.8.4.rc3
