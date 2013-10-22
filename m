From: sre@debian.org (Sebastian Reichel)
Date: Tue, 22 Oct 2013 14:55:00 +0200
Subject: [PATCH 0/4] Add N900 powerbutton DT support
Message-ID: <1382446504-27837-1-git-send-email-sre@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for the Nokia N900
powerbutton.

Currently non-DT boot crashes for me very early,
so I was not able to check this patch using non-DT
boot.

It would be nice if somebody can check if the first
patch works using non-DT boot. It should be enough
to test it with any omap3 board using the twl4030
power button.

Sebastian Reichel (4):
  Input: twl4030-pwrbutton - add device tree support
  Input: twl4030-pwrbutton: use dev_err for errors
  Input: twl4030-pwrbutton: simplify driver using devm_*
  ARM: dts: twl4030: Add power button support

 arch/arm/boot/dts/twl4030.dtsi         |  5 +++++
 drivers/input/misc/twl4030-pwrbutton.c | 33 ++++++++++++++++++++-------------
 2 files changed, 25 insertions(+), 13 deletions(-)

-- 
1.8.4.rc3
