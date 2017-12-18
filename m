From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 18 Dec 2017 10:44:39 +0100
Subject: [PATCH net-next v3 0/7] net: phy: meson-gxl: clean-up and improvements
Message-ID: <20171218094446.31912-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds defines for the control registers and helpers to access
the banked registers. The goal being to make it easier to understand what
the driver actually does.
Then CONFIG_A6 settings is removed since this statement was without effect
Finally interrupt support is added, speeding things up a little

This series has been tested on the libretech-cc and khadas VIM

Changes since v2 [0]:
Drop LPA corruption fix which has been merged through net. Apart from this,
series remains the same.

[0]: https://lkml.kernel.org/r/20171207142715.32578-1-jbrunet at baylibre.com

Jerome Brunet (7):
  net: phy: meson-gxl: check phy_write return value
  net: phy: meson-gxl: define control registers
  net: phy: meson-gxl: add read and write helpers for banked registers
  net: phy: meson-gxl: use genphy_config_init
  net: phy: meson-gxl: leave CONFIG_A6 untouched
  net: phy: meson-gxl: add interrupt support
  net: phy: meson-gxl: join the authors

 drivers/net/phy/meson-gxl.c | 185 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 146 insertions(+), 39 deletions(-)

-- 
2.14.3
