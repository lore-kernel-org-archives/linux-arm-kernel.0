From: sergio.prado@e-labworks.com (Sergio Prado)
Date: Fri, 17 Mar 2017 22:13:51 -0300
Subject: [PATCH v5 0/2] mmc: host: s3cmci: add device tree support
Message-ID: <1489799633-29278-1-git-send-email-sergio.prado@e-labworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for configuring Samsung's S3C24XX MMC/SD/SDIO
controller via device tree.

Tested on FriendlyARM mini2440, based on s3c2440 SoC.

Changes since v4 (as suggested by Jaehoon Chung):
- using just a flag as a data structure for the driver to check for
  s3c2400 compatibility

Changes since v3 (as suggested by Rob Herring):
- describing properties that wasn't documented and removing unnecessary
  comment in the device tree binding

Changes since v2:
- struct "s3cmci_drv_data" and flag "is2440" renamed
- copying the whole driver data struct instead of only its member so
  it will be easier to extend the information in the future
- using mmc_of_parse() to read "cd-gpios" and "wp-gpios" properties
  from device tree

Changes since v1:
- pinctrl description removed from DT binding
- unit and label on DT binding renamed to mmc

Sergio Prado (2):
  dt-bindings: mmc: add DT binding for S3C24XX MMC/SD/SDIO controller
  mmc: host: s3cmci: allow probing from device tree

 .../devicetree/bindings/mmc/samsung,s3cmci.txt     |  42 ++++
 drivers/mmc/host/s3cmci.c                          | 257 ++++++++++-----------
 2 files changed, 168 insertions(+), 131 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/samsung,s3cmci.txt

-- 
1.9.1
