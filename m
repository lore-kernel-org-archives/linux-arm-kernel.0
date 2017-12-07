From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu,  7 Dec 2017 15:27:07 +0100
Subject: [PATCH net-next v2 0/8] phy: net: meson-gxl: clean-up and improvements
Message-ID: <20171207142715.32578-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patchset is a v2 of the previous single clean-up patch [0] which was
part of larger series. I initially to send these patches separately but
adding helper function without using them did not make much sense after
all. So, here is the complete patchset.

This patchset add defines for the control registers and helpers to access
the banked registers. The goal being to make it easier to understand what
the driver actually does.

Then there is fix for the incorrect sampling of the MII LPA register which
is often breaking the auto-negotiation with this PHY. More details on this
in the related patch

CONFIG_A6 settings is removed since this statement was without effect

Finally interrupt support is added, speeding things up a little

This series has been tested on the libretech-cc and khadas VIM

Jerome Brunet (8):
  net: phy: meson-gxl: check phy_write return value
  net: phy: meson-gxl: define control registers
  net: phy: meson-gxl: add read and write helpers for bank registers
  net: phy: meson-gxl: use genphy_config_init
  net: phy: meson-gxl: detect LPA corruption
  net: phy: meson-gxl: leave CONFIG_A6 untouched
  net: phy: meson-gxl: add interrupt support
  net: phy: meson-gxl: join the authors

 drivers/net/phy/meson-gxl.c | 215 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 197 insertions(+), 18 deletions(-)

-- 
2.14.3
