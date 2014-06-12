From: agross@codeaurora.org (Andy Gross)
Date: Thu, 12 Jun 2014 14:34:09 -0500
Subject: [Patch v2 0/3] spi: qup: Fixes and new version support
Message-ID: <1402601652-24641-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set of patches provides a few fixes for the SPI QUP driver and support for
an earlier version of the QUP.

The first patch removes the use of the controller's own chip select
functionality.  The user should instead use GPIOs and make use of the SPI core's
GPIO chip select feature.

The second patch addresses failures during probing of slave devices that
required SPI transactions.  The spi_register_master needs to be called after
the runtime pm is initialized.

The last patch adds support for V1.1.1 of the QUP.  This version of the
controller is present in earlier devices (APQ8064, IPQ8064, and MSM8960).

Andy Gross (3):
  spi: qup: Remove chip select function
  spi: qup: Fix order of spi_register_master
  spi: qup: Add support for v1.1.1

 .../devicetree/bindings/spi/qcom,spi-qup.txt       |   12 ++-
 drivers/spi/spi-qup.c                              |   80 +++++++++-----------
 2 files changed, 46 insertions(+), 46 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
