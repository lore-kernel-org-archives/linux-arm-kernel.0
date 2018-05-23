From: ray.jui@broadcom.com (Ray Jui)
Date: Wed, 23 May 2018 13:32:01 -0700
Subject: [PATCH v2 0/6]Enhance support for the SP805 WDT
Message-ID: <1527107527-8093-1-git-send-email-ray.jui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series enhances the support for the SP805 watchdog timer.
First of all, 'timeout-sec' devicetree property is added. In addition,
support is also added to allow the driver to reset the watchdog if it
has been detected that watchdot has been started in the bootloader. In
this case, the driver will initiate the ping service from the kernel
watchdog subsystem, before a user mode daemon takes over. This series
also enables SP805 in the default ARM64 defconfig

This patch series is based off v4.17-rc5 and is available on GIHUB:
repo: https://github.com/Broadcom/arm64-linux.git
branch: sp805-wdt-v2

Changes since v1:
 - Consolidate two duplicated SP805 binding documents into one
 - Slight change of the wdt_is_running implementation per discussion

Ray Jui (6):
  Documentation: DT: Consolidate SP805 binding docs
  Documentation: DT: Add optional 'timeout-sec' property for sp805
  watchdog: sp805: add 'timeout-sec' DT property support
  watchdog: sp805: set WDOG_HW_RUNNING when appropriate
  arm64: dt: set initial SR watchdog timeout to 60 seconds
  arm64: defconfig: add CONFIG_ARM_SP805_WATCHDOG

 .../devicetree/bindings/watchdog/arm,sp805.txt     | 22 ++++++++++++---
 .../devicetree/bindings/watchdog/sp805-wdt.txt     | 31 ----------------------
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  1 +
 arch/arm64/configs/defconfig                       |  1 +
 drivers/watchdog/sp805_wdt.c                       | 28 ++++++++++++++++++-
 5 files changed, 47 insertions(+), 36 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/watchdog/sp805-wdt.txt

-- 
2.1.4
