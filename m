From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  6 Sep 2012 14:48:06 +0200
Subject: [PATCH v3] pwm i.MX: add devicetree support
Message-ID: <1346935695-25179-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following is the third version of the i.MX pwm series. I integrated
the remaining comments from Shawn and Beno?t and added their tags.

So Thierry, please pull the attached patches. The pull request only
contains the pwm framework specific patches, the remaining two I'd
like to push via the arm-soc tree in case the i.MX5 also gets devicetree
clock lookups.

Sascha


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

for you to fetch changes up to 8424520ae5f2ad2c8c6cd5e990054cf06f479006:

  pwm i.MX: fix clock lookup (2012-09-06 12:35:58 +0200)

----------------------------------------------------------------
This series cleans up the i.MX PWM driver and converts it to
devicetree probing.

----------------------------------------------------------------
Philipp Zabel (2):
      pwm i.MX: add devicetree support
      pwm i.MX: fix clock lookup

Sascha Hauer (5):
      pwm i.MX: factor out SoC specific functions
      pwm i.MX: remove unnecessary if in pwm_[en|dis]able
      pwm i.MX: add functions to enable/disable pwm.
      pwm i.MX: Use module_platform_driver
      pwm i.MX: use per clock unconditionally

 Documentation/devicetree/bindings/pwm/imx-pwm.txt |   17 ++
 drivers/pwm/pwm-imx.c                             |  277 ++++++++++++++-------
 2 files changed, 198 insertions(+), 96 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/imx-pwm.txt
