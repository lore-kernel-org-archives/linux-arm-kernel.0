From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 05 Oct 2011 15:42:58 +0530
Subject: [PATCH 0/3] mmc: sdhci-s3c: Add device tree support for Samsung's
	sdhci controller driver
Message-ID: <1317809581-28783-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds device tree support for Samsung's sdhci controller driver.

The first patch modifies the sdhcis-s3c driver to mainatain a local copy of the
platform data, which makes it easier to add device tree support for the driver.

The second patch adds support for parsing of mmc host controller capabilities
from a device node. This code would be reusable across other platforms as well.
The third patch device tree based discovery for the sdhci-s3c driver.

This patchset is based on the following tree:
https://github.com/kgene/linux-samsung.git  branch: for-next
and tested on smdkv310 board.

Thomas Abraham (3):
  mmc: sdhci-s3c: Keep a copy of platform data and use it
  mmc: Add OF bindings support for mmc host controller capabilities
  mmc: sdhci-s3c: Add device tree support

 .../devicetree/bindings/mmc/linux-mmc-host.txt     |   11 ++
 .../devicetree/bindings/mmc/samsung-sdhci.txt      |   75 ++++++++++
 drivers/mmc/core/host.c                            |   31 ++++
 drivers/mmc/host/sdhci-s3c.c                       |  155 +++++++++++++++++++-
 include/linux/mmc/host.h                           |    3 +
 5 files changed, 270 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/linux-mmc-host.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/samsung-sdhci.txt
