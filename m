From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu, 16 Jul 2015 23:25:47 +0530
Subject: [PATCH-v3 0/2] mfd: 88pm800: Add 88pm860 device support
Message-ID: <1437069349-15015-1-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

88PM860 falls under 88pm800 family of devices, with some feature
additions, for example, support for dual phase on BUCK1.

This patch series, enabled chip ID support for 88pm860 in the driver
and adds Init time configuration support based on chip ID

V2 => V3
=======
Link to V2: https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg931170.html

  - Mistakenly introduced warning in V2, unused variable 'val'
    Fixed it.
    Note that no other code change compared to V2.

V1 => V2
========
 - Dropped PATCH [03/06 to 06/06]
    PATCH [03 & 04]: New clock provider driver is under development for
    32KHz clock output enable/disable

    PATCH [05 & 06]: Moved to regulator driver and will be part of regulator
    changes patch-series, as dual-phase configuration belongs to regulator.

  - Added Acked-by of "Krzysztof Kozlowski"

  - Added comment into the code for missing init configuration for
    88pm800 & 88pm805 device.

TODO:
  - Some of init time configurations are common to both 88pm800 and 88pm860
    devices, but since I can not validate it, decided to move it to
    88pm860 block only.
    But if someone is willing to help me in validation, we can move it to
    common code later. No issues there.
  - Sleep/low-power-mode related configuration is also part of init time,
    but since we are too far from sleep mode support and without testing
    I do not want add anything, decided to take it later when we actually
    start looking at sleep support.
  - Init time configuration also includes pinmux setting for the device.
    I am working on using pinctrl-single driver to have standard and generic
    interface, hopefully it will get handled through pinctrl subsystem.
      Link to RFC - https://patches.linaro.org/50604/

Vaibhav Hiremath (2):
  mfd: 88pm80x: Add 88pm860 chip type support
  mfd: 88pm800: Add init time initial configuration support

 drivers/mfd/88pm800.c       | 70 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/mfd/88pm80x.c       |  2 ++
 include/linux/mfd/88pm80x.h | 14 +++++++++
 3 files changed, 86 insertions(+)

-- 
1.9.1
