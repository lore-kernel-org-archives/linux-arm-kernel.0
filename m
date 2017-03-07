From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue,  7 Mar 2017 14:30:59 +0100
Subject: [PATCH 0/3] pinctrl: meson: Fix and add missing pins definitions
Message-ID: <1488893462-7016-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset fixes the GXBB and GXL pins definitions and add missing GXL
pins to have an 1:1 support for GXBB and GXL.

The error in the current GXL pins definitions was only some bits inversions
in same groups, behaviour should be the same.

Missing pins on GXL was the UART rts/cts, NOR pins, AO i2c and a PWM alias.

Neil Armstrong (3):
  pinctrl: meson-gxbb: Fix typo in i2c ao groups
  pinctrl: meson-gxl: Fix inverted registers and add missing pins
  ARM64: dts: meson-gxl: Add missing pinctrl pins groups

 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 32 +++++++++++
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c |  4 +-
 drivers/pinctrl/meson/pinctrl-meson-gxl.c  | 86 +++++++++++++++++++++++++-----
 3 files changed, 106 insertions(+), 16 deletions(-)

-- 
1.9.1
