From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 23 Apr 2018 14:41:46 +0200
Subject: [PATCH v2 0/3] nvmem: meson-efuse: add write support
Message-ID: <20180423124149.3077-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This changeset adds write support to meson efuse driver.
The first patch just changes the way the nvmem data are allocated w/o
any functional changes. The second patches actually adds write support.

The memory being an OTP, it is safer if it remains read-only by default,
which is why I also submitted this DT patch [0]. It has now been merged by
Kevin.

If a user knows what he is doing, it should be easy to remove the
read-only property from the board DT. This can be done in u-boot, before
starting linux:

 > fdt rm /efuse read-only

Tested on the gxl libretech-cc

Changes since v1 [1]:
 - Remove un-necessary code in callbacks
 - Rebase on v4.17-rc1

[0]: https://lkml.kernel.org/r/20180316145021.8517-1-jbrunet at baylibre.com
[1]: https://lkml.kernel.org/r/20180316150113.9779-1-jbrunet at baylibre.com

Jerome Brunet (3):
  nvmem: meson-efuse: remove econfig global
  nvmem: meson-efuse: simplify read callback
  nvmem: meson-efuse: add write support

 drivers/nvmem/meson-efuse.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

-- 
2.14.3
