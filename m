From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 10 Apr 2015 12:09:00 +0800
Subject: [PATCH RESEND v6 0/6] mfd: axp20x: add AXP221 PMIC support
Message-ID: <1428638946-24890-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

This is a resend of the AXP221 PMIC series, rebased onto the latest
for-mfd-next.

Original changelog

Changes since v5:

    - Rebased onto mfd-for-next (ba867bc60a44)

    - Dropped dts patches

    - Removed double line spacing

Changes since v4:

  - Rebased onto v4.0-rc1 and axp20x bindings v10

  - Dropped regulator set registration patches

  - Group regmap ranges/tables by AXP variant

  - Fix AXP221 interrupt numbers to match datasheet

  - Handle AXP variants when setting DC-DC regulator work mode

  - Add "switch" type regulator DC1SW, which is a secondary output
    of DCDC1 with a separate on/off switch.

  - Add AXP221 to DT bindings


Regards
ChenYu

Boris BREZILLON (3):
  mfd: axp20x: add AXP22x PMIC support
  regulator: axp20x: prepare support for multiple AXP chip families
  regulator: axp20x: add support for AXP22X regulators

Chen-Yu Tsai (3):
  mfd: axp20x: update DT bindings with AXP22x compatibles
  mfd: axp20x: Add AXP22x regulator information to DT bindings
  mfd: axp20x: Enable AXP22X regulators

 Documentation/devicetree/bindings/mfd/axp20x.txt |  32 ++-
 drivers/mfd/axp20x.c                             | 100 ++++++++++
 drivers/regulator/axp20x-regulator.c             | 239 ++++++++++++++++++-----
 include/linux/mfd/axp20x.h                       |  86 ++++++++
 4 files changed, 405 insertions(+), 52 deletions(-)

-- 
2.1.4
