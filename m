From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 10 Sep 2012 10:59:30 +0200
Subject: [PATCH v4] pwm: i.MX: add devicetree support
Message-ID: <1347267577-3296-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Changes since v3:

- Change patches to subject 'pwm:'
- Use uppercase PWM when referring to PWMs
- Change commit message for "factor out SoC specific functions" patch

Changes since v2:

- check return value of clk_prepare_enable
- remove platform based probing

Changes since v1:

- Add devicetree binding documentation
- Merge 5/9 and 9/9
- fix #pwm-cells (must be 2 instead of 3)
- fix wrong name in MODULE_DEVICE_TABLE
- drop platform based probing while introducing devicetree based probe


The following changes since commit fea7a08acb13524b47711625eebea40a0ede69a0:

  Linux 3.6-rc3 (2012-08-22 13:29:06 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx-pwm-oftree

for you to fetch changes up to 5e39af20dedff5dca77c36209ddb09729cfe090e:

  pwm: i.MX: fix clock lookup (2012-09-10 10:40:27 +0200)

----------------------------------------------------------------
Cleanup i.MX PWM driver and add devicetree support

----------------------------------------------------------------
Philipp Zabel (2):
      pwm: i.MX: add devicetree support
      pwm: i.MX: fix clock lookup

Sascha Hauer (5):
      pwm: i.MX: factor out SoC specific functions
      pwm: i.MX: remove unnecessary if in pwm_[en|dis]able
      pwm: i.MX: add functions to enable/disable pwm.
      pwm: i.MX: Use module_platform_driver
      pwm: i.MX: use per clock unconditionally

 Documentation/devicetree/bindings/pwm/imx-pwm.txt |   17 ++
 drivers/pwm/pwm-imx.c                             |  278 ++++++++++++++-------
 2 files changed, 199 insertions(+), 96 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/imx-pwm.txt
