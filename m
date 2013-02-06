From: anilkumar.v@ti.com (Kumar, Anil)
Date: Wed, 6 Feb 2013 09:30:02 +0530
Subject: [PATCH V2 0/2] ARM: davinci: da850: add wdt DT node
Message-ID: <1360123204-9978-1-git-send-email-anilkumar.v@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add wdt DT node and OF_DEV_AUXDATA for wdt driver in
da850 board dt file to use wdt clock.

This is tested on da850 EVM.

Test Procedure:

$watchdog -F /dev/watchdog (Device should not reboot)
 After wdt heartbeat timeout(DEFAULT_HEARTBEAT is 60 sec)
$ctr + c   (Device should reboot after heartbeat timeout)

Changes since V1:

 - Rebase changes on top of v3.8-rc6.
 - Make single patch for wdt DT node and its OF_DEV_AUXDATA entry changes.
 - Fix wdt to machine restart with DT.

Kumar, Anil (2):
  ARM: davinci: da850: add wdt DT node
  ARM: davinci: restart: fix wdt to machine restart with DT

 arch/arm/boot/dts/da850-evm.dts            |    3 +++
 arch/arm/boot/dts/da850.dtsi               |    5 +++++
 arch/arm/mach-davinci/da8xx-dt.c           |    8 +++++++-
 arch/arm/mach-davinci/devices-da8xx.c      |   14 ++++++++++++--
 arch/arm/mach-davinci/include/mach/da8xx.h |    1 -
 5 files changed, 27 insertions(+), 4 deletions(-)

-- 
1.7.4.1
