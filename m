From: gdjakov@mm-sol.com (Georgi Djakov)
Date: Fri, 23 May 2014 18:12:28 +0300
Subject: [PATCH v2 0/4] Add Qualcomm APQ8084 SoC support
Message-ID: <1400857952-6963-1-git-send-email-gdjakov@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds basic support for the Qualcomm Snapdragon 805 APQ8084 SoC.

The first two patches add device-tree files for the SoC and the board, the
third adds a board compatible string to the DT machine descriptor.
The last one adds information about the low-level debug UART base address
to the DEBUG_QCOM_UARTDM Kconfig help section introduced by [1].

Tested on APQ8084-MTP board.

Changes from v1:
 - Remove the interrupts property from the l2-cache node as it is still not
   accepted (suggested by Stephen Boyd)
 - Move the timer node out of the soc container (suggested by Stephen Boyd)
 - Add just "qcom,apq8084" in the board machine descriptors to cover other
   future boards based on apq8084 (suggested by Kumar Gala)
 - Change the last patch (debug UART) to just add info about the SoC PHYS/VIRT
   addresses. Requires [1]. (suggestions by Arnd Bergmann and Ivan Ivanov)

[1] https://lkml.org/lkml/2014/4/14/312

Georgi Djakov (4):
  ARM: dts: qcom: Add APQ8084 SoC support
  ARM: dts: qcom: Add APQ8084-MTP board support
  ARM: qcom: Add APQ8084 to mach-qcom
  ARM: debug: qcom: add UART addresses to Kconfig help

 arch/arm/Kconfig.debug                 |    1 +
 arch/arm/boot/dts/Makefile             |    3 +-
 arch/arm/boot/dts/qcom-apq8084-mtp.dts |    6 ++
 arch/arm/boot/dts/qcom-apq8084.dtsi    |  179 ++++++++++++++++++++++++++++++++
 arch/arm/mach-qcom/board.c             |    1 +
 5 files changed, 189 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/qcom-apq8084-mtp.dts
 create mode 100644 arch/arm/boot/dts/qcom-apq8084.dtsi

-- 
1.7.9.5
