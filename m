From: anilkumar.v@ti.com (Kumar, Anil)
Date: Thu, 24 Jan 2013 14:08:13 +0530
Subject: [PATCH 0/2] ARM: davinci: da850: add wdt DT node
Message-ID: <1359016695-10362-1-git-send-email-anilkumar.v@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add wdt DT node and OF_DEV_AUXDATA for wdt driver in
da850 board dt file to use wdt clock.

This series applies on top of v3.8-rc4.

This is tested on da850 EVM.

Test Procedure:

$watchdog -F /dev/watchdog (Device should not reboot)
 After wdt heartbeat timeout(DEFAULT_HEARTBEAT is 60 sec)
$ctr + c   (Device should reboot after heartbeat timeout)

Kumar, Anil (2):
  ARM: davinci: da850: add wdt DT node
  ARM: davinci: da850: add wdt OF_DEV_AUXDATA entry

 arch/arm/boot/dts/da850-evm.dts  |    3 +++
 arch/arm/boot/dts/da850.dtsi     |    5 +++++
 arch/arm/mach-davinci/da8xx-dt.c |    8 +++++++-
 3 files changed, 15 insertions(+), 1 deletions(-)

-- 
1.7.4.1
