From: anson.huang@nxp.com (Anson Huang)
Date: Wed, 28 Nov 2018 05:20:57 +0000
Subject: [PATCH V2 0/4] Add i.MX system controller RTC driver
Message-ID: <1543382119-2918-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as
system controller, the system controller is in charge of system
power, clock and secure RTC etc. management, Linux kernel
has to communicate with system controller via MU (message unit)
IPC to do RTC operation.

Since the RTC set time MUST to be done in secure EL3 mode (required
by system controller firmware) and ALARM functions needs to be done
with general MU IRQ handle, these are NOT ready NOW, so this patch
ONLY supports RTC read time for now.

Note that this patch set is based on [V4,5/5] defconfig: arm64: add imx8qxp support,
https://patchwork.kernel.org/patch/10677315/

Anson Huang (4):
  dt-bindings: rtc: add binding doc for i.MX system controller RTC
    driver
  rtc: add i.MX system controller RTC support
  defconfig: arm64: add i.MX system controller RTC support
  ARM64: dts: imx: add i.MX8QXP system controller RTC support

 .../devicetree/bindings/rtc/rtc-imx-sc.txt         |  10 ++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi         |   4 +
 arch/arm64/configs/defconfig                       |   1 +
 drivers/rtc/Kconfig                                |   6 ++
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-imx-sc.c                           | 107 +++++++++++++++++++++
 6 files changed, 129 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-imx-sc.txt
 create mode 100644 drivers/rtc/rtc-imx-sc.c

-- 
2.7.4
