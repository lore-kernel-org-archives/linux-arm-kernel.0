From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Mon, 29 Jun 2015 16:52:16 +0530
Subject: [RFC PATCH v6 0/3] Implement NVMEM/SoC bus support for Vybrid
In-Reply-To: <558A99FC.2070902@i2se.com>
References: <558A99FC.2070902@i2se.com>
Message-ID: <cover.1435574288.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

For what it's worth, a reworked implementation of the OCOTP driver
implementing the proper fuse and shadow register read sequence as
mentioned in the TRM.

I will avoid unnecessary churn after this and send the next v7 once
the nvmem framework gets merged.

Used the OCOTP code in barebox as a reference and the code is highly
similar to that. iMX6 OCOTP memory map is however different to Vybrid.

This set also does not contain code for exposing the ROM information,
have yet to check that.

Feedback and comments are most welcome. Thank you for all the reviews
till now.

Regards,
Sanchayan.

Sanchayan Maity (3):
  clk: clk-vf610: Add clock for Vybrid OCOTP controller
  ARM: dts: vfxxx: Add OCOTP node
  drivers: nvmem: Add Vybrid OCOTP support

 arch/arm/boot/dts/vfxxx.dtsi            |   7 +
 drivers/clk/imx/clk-vf610.c             |   1 +
 drivers/nvmem/Kconfig                   |  10 ++
 drivers/nvmem/Makefile                  |   2 +
 drivers/nvmem/vf610-ocotp.c             | 250 ++++++++++++++++++++++++++++++++
 include/dt-bindings/clock/vf610-clock.h |   3 +-
 6 files changed, 272 insertions(+), 1 deletion(-)
 create mode 100644 drivers/nvmem/vf610-ocotp.c

-- 
2.4.4
