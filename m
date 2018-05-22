From: ray.jui@broadcom.com (Ray Jui)
Date: Tue, 22 May 2018 11:47:15 -0700
Subject: [PATCH 0/5] Enhance support for the SP805 WDT
Message-ID: <1527014840-21236-1-git-send-email-ray.jui@broadcom.com>
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
branch: sp805-wdt-v1

Ray Jui (5):
  Documentation: DT: Add optional 'timeout-sec' property for sp805
  watchdog: sp805: add 'timeout-sec' DT property support
  watchdog: sp805: set WDOG_HW_RUNNING when appropriate
  arm64: dt: set initial SR watchdog timeout to 60 seconds
  arm64: defconfig: add CONFIG_ARM_SP805_WATCHDOG

 .../devicetree/bindings/watchdog/sp805-wdt.txt     |  2 ++
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  1 +
 arch/arm64/configs/defconfig                       |  1 +
 drivers/watchdog/sp805_wdt.c                       | 31 +++++++++++++++++++++-
 4 files changed, 34 insertions(+), 1 deletion(-)

-- 
2.1.4
