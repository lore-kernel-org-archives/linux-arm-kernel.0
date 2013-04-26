From: cb@sgoc.de (Christoph G. Baumann)
Date: Fri, 26 Apr 2013 13:20:13 +0200
Subject: [PATCH 0/2] crypto: added support for fsl-dcp on iMX23,28,50
Message-ID: <1366975215-5420-1-git-send-email-cb@sgoc.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Christoph G. Baumann" <cb@sgoc.de>

This patch is based on the original driver by Freescale.
The driver gives access to the DCP crypto core which can accelerate
AES and SHA operations.
It was ported to the current API and sanitized to please checkpatch.pl.

Christoph G. Baumann (2):
  crypto: added support for fsl-dcp on iMX23,28,50
  crypto: added support for fsl-dcp on iMX23,28,50

 arch/arm/boot/dts/imx28.dtsi                 |    2 +-
 drivers/staging/Kconfig                      |    2 +
 drivers/staging/Makefile                     |    1 +
 drivers/staging/crypto/Kconfig               |   15 +
 drivers/staging/crypto/Makefile              |    1 +
 drivers/staging/crypto/fsl-dcp.c             | 1790 ++++++++++++++++++++++++++
 drivers/staging/crypto/fsl-dcp.h             |  739 +++++++++++
 include/linux/fsl/fsl-dcp_bootstream_ioctl.h |   32 +
 8 files changed, 2581 insertions(+), 1 deletion(-)
 create mode 100644 drivers/staging/crypto/Kconfig
 create mode 100644 drivers/staging/crypto/Makefile
 create mode 100644 drivers/staging/crypto/fsl-dcp.c
 create mode 100644 drivers/staging/crypto/fsl-dcp.h
 create mode 100644 include/linux/fsl/fsl-dcp_bootstream_ioctl.h

-- 
1.7.9.5
