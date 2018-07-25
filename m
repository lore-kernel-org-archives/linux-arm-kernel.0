From: mylene.josserand@bootlin.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Wed, 25 Jul 2018 09:34:07 +0200
Subject: [PATCH v4 0/3] sun8i-a83t: Add touchscreen support on TBS A711
Message-ID: <20180725073410.730-1-mylene.josserand@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everyone,

This is a V4 of the patch series that adds touchscreen support
(FocalTech EDT-FT5x06 Polytouch) for TBS A711 (Allwinner sun8i-a83t SoC)
and add regulator support for this touchscreen.
Based on last master of linux-input tree.

Changes since v3:
   - Created a new function to disable regulator via
   devm_add_action_or_reset (Dmitry Torokhov's review)
   - Moved regulator_enable/disable functions in device_may_wakeup
   guard (Ond?ej Jirman and Dmitry Torokhov's reviews)
   - Added Rob Herring Reviewed-by on patch 01 (sorry again)
Changes since v2:
   - Removed the check if regulator is NULL (Dmitry Torokhov's review)
   - Added EPROBE_DEFER error not to print a error message (Lothar Wa?mann's review)
   - Added set wake/reset on suspend/resume.
Changes since v1:
   - Removed patches 01 and 02 as Chen-Yu Tsai sent a similar patch:
   https://patchwork.kernel.org/patch/10111431/
   and it is merged on last next-20171222.
   (See commit f066f46ce5a5 "ARM: dts: sun8i: a83t: Add I2C device nodes and pinmux settings")
   - Updated regulator according to Dmitry Torokhov's review: removed "optional"
   suffix while retrieving the regulator, renamed it into "vcc" instead of
   "power" and added bindings documentation.
   - Updated device tree according to Maxime Ripard's review: remove the
   label and rename the node.
   - Squashed patch 03 with patch 05 to add I2C0 and touchscreen's node
   in one patch (see patch 02).

Patch 01: Add support for regulator in the FocalTech touchscreen driver
because A711 tablet is using a regulator to power-up the touchscreen.
Patch 02: Add a set wake/reset values on resume and suspend.
Patch 03: Add i2c0 and touchscreen's node for A711 TBS tablet.

Thank you in advance for any review.
Best regards,
Myl?ne

Myl?ne Josserand (3):
  Input: edt-ft5x06 - Add support for regulator
  Input: edt-ft5x06 - Set wake/reset values on resume/suspend
  arm: dts: sun8i: a83t: a711: Add touchscreen node

 .../bindings/input/touchscreen/edt-ft5x06.txt      |  1 +
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts          | 16 +++++++
 drivers/input/touchscreen/edt-ft5x06.c             | 55 ++++++++++++++++++++++
 3 files changed, 72 insertions(+)

-- 
2.11.0
