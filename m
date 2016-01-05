From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  5 Jan 2016 15:02:07 +0100
Subject: [PATCH 0/2] Add LEDs support for the ARM Versatile DT
Message-ID: <1452002529-3335-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for the board LEDs to the ARM Versatile device tree
version.

I can't decice if this is a regression or not. The board file version
of Versatile supported the LEDs, the Device Tree version never did
until now.

The board file version of Versatile was deleted in
commit 16956fed35fecde2201e23458cda193526b19559
"ARM: versatile: switch to DT only booting and remove legacy code"

If we consider the DT version a full drop-in replacement for the
board file version, then this should go in as a regression fix. If
it is not, we can delay it to the next merge window.

Sending this to arm at kernel.org anyway so the ARM SoC maintainers can
decide.

Linus Walleij (2):
  ARM: versatile: add the syscon LEDs to the DT
  ARM: versatile: enable the right LEDs

 arch/arm/boot/dts/versatile-ab.dts   | 62 +++++++++++++++++++++++++++++++++++-
 arch/arm/configs/versatile_defconfig |  3 +-
 2 files changed, 63 insertions(+), 2 deletions(-)

-- 
2.4.3
