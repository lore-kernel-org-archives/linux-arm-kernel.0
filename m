From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 23 Mar 2017 11:41:09 +0100
Subject: [PATCH v2 0/2] pinctrl: meson: Fix and add missing pins definitions
Message-ID: <20170323104112.16558-1-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset fixes the GXBB and GXL pins definitions and add missing GXL
pins to have an 1:1 support for GXBB and GXL.

The error in the current GXL pins definitions was only some bits inversions
in same groups, behaviour should be the same.

Missing pins on GXL was the UART rts/cts, NOR pins, AO i2c and a PWM alias.

Changes since v1 at [1]:
 - Dropped already applied "pinctrl: meson-gxbb: Fix typo in i2c ao groups"
 - Moved pwm_ao_b_6 in the pwm_ao_b function, in pinctrl and DT
 - Rebased on pinctrl/devel branch

[1] http://lkml.kernel.org/r/1488893462-7016-1-git-send-email-narmstrong at baylibre.com

Neil Armstrong (2):
  pinctrl: meson-gxl: Fix inverted registers and add missing pins
  ARM64: dts: meson-gxl: Add missing pinctrl pins groups

 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 32 ++++++++++++
 drivers/pinctrl/meson/pinctrl-meson-gxl.c  | 83 ++++++++++++++++++++++++------
 2 files changed, 100 insertions(+), 15 deletions(-)

-- 
2.7.0
