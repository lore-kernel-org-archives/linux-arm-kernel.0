From: cb@sgoc.de (Christoph G. Baumann)
Date: Wed,  3 Jul 2013 14:39:11 +0200
Subject: [PATCH 0/3] Added support for On Chip OTP in i.MX23/28
Message-ID: <1372855154-8422-1-git-send-email-cb@sgoc.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Christoph G. Baumann" <cb@sgoc.de>

This patch contains the ported driver from Freescale for the On Chip OTP
cells in the i.MX23 and i.MX28. The OTP cells can be read and written via
files in /sys/fsl_otp.

Christoph G. Baumann (3):
  Added support for On Chip OTP in i.MX23/28
  Added support for On Chip OTP in i.MX23/28
  Added support for On Chip OTP in i.MX23/28

 arch/arm/boot/dts/imx28.dtsi                |    1 -
 arch/arm/mach-mxs/include/mach/mx23-ocotp.h |  311 +++++++++++++++++++++++++++
 arch/arm/mach-mxs/include/mach/mx28-ocotp.h |  239 ++++++++++++++++++++
 drivers/clk/mxs/clk-imx23.c                 |    2 +
 drivers/clk/mxs/clk-imx28.c                 |    1 +
 drivers/misc/Kconfig                        |   14 ++
 drivers/misc/Makefile                       |    1 +
 drivers/misc/fsl_otp.c                      |  249 +++++++++++++++++++++
 drivers/misc/fsl_otp.h                      |  201 +++++++++++++++++
 9 files changed, 1018 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-mxs/include/mach/mx23-ocotp.h
 create mode 100644 arch/arm/mach-mxs/include/mach/mx28-ocotp.h
 create mode 100644 drivers/misc/fsl_otp.c
 create mode 100644 drivers/misc/fsl_otp.h

-- 
1.7.9.5
