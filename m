From: cb@sgoc.de (Christoph G. Baumann)
Date: Wed, 17 Jul 2013 18:27:37 +0200
Subject: [PATCH v2 0/3] mxs: add driver for On Chip OTP
In-Reply-To: <1372855154-8422-1-git-send-email-cb@sgoc.de>
References: <1372855154-8422-1-git-send-email-cb@sgoc.de>
Message-ID: <1374078460-4126-1-git-send-email-cb@sgoc.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Christoph G. Baumann" <cb@sgoc.de>

This patch brings read/write support for the On Chip OTP cells in the i.MX23
and i.MX28 processor. The driver uses files (one for each cell) in /sys/fsl_otp
as interface. The original code from Freescale was stripped down to the
required minimum and ported to 3.x kernels.

Christoph G. Baumann (3):
  mxs: enable ocotp in device tree
  mxs: register clkdev "hbus" as it is required by OCOTP driver
  mxs: added driver for OCOTP in i.MX23 and i.MX28

 arch/arm/boot/dts/imx23.dtsi |    1 -
 arch/arm/boot/dts/imx28.dtsi |    1 -
 drivers/clk/mxs/clk-imx23.c  |    2 +
 drivers/clk/mxs/clk-imx28.c  |    1 +
 drivers/misc/Kconfig         |   14 ++
 drivers/misc/Makefile        |    1 +
 drivers/misc/fsl_otp.c       |  363 ++++++++++++++++++++++++++++++++++++++++++
 drivers/misc/fsl_otp.h       |  126 +++++++++++++++
 8 files changed, 507 insertions(+), 2 deletions(-)
 create mode 100644 drivers/misc/fsl_otp.c
 create mode 100644 drivers/misc/fsl_otp.h

-- 
1.7.9.5
