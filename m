From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Sat,  5 Jan 2013 10:38:40 +0800
Subject: [v3 PATCH 0/9] watchdog/at91sam9_wdt: Convert to use the new framework
Message-ID: <1357353529-20901-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, All

The purpose of the patch series is to convert to use the watchdog framework,
It is tested on at91sam9g25ek.

It is based on v3.8-rc2 + Fabio Porcedda's add timeout-sec property binding

ChangeLog 
v3:
	1./ The helper function 'watchdog_is_open' is moved to
	    include/linux/watchdog.h, as it can be useful for other watchdog
	    drivers as well.

	2./ Remove '__init' annotation from the function 'at91wdt_probe',
	    since the driver becomes hot-plug aware now.
	
	3./ Rebase on v3.8-rc2

v2:
	1./ Remove the patches to add devive tree support which Fabio Porcedda
	   has done and submitted.

	2./ Replace __raw_readl, __raw_writel with readl_relaxed, writel_relaxed.

	3./ Rebase on v3.7-rc8.

Best Regards
Wenyou Yang

Wenyou Yang (9):
  watchdog: add the function watchdog_is_open
  watchdog/at91sam9_wdt: Remove at91wdt_private and add at91wdt_drvdata
    struct
  watchdog/at91sam9_wdt: Convert to use the watchdog framework
  watchdog/at91sam9_wdt: Adjust the options of watchdog_info
  watchdog/at91sam9_wdt: Add nowayout helpers to Watchdog Timer Driver
    Kernel API
  watchdog/at91sam9_wdt: Remove the __initdata of at91wdt_wdd
  watchdog/at91sam9_wdt: Use module_platform_driver()
  ARM: dts: add the watchdog nodes for at91sam9x5 and at91sam9n12 SoC
  ARM: dts: add the watchdog nodes for at91sam9g25ek boards

 arch/arm/boot/dts/at91sam9n12.dtsi  |    6 +
 arch/arm/boot/dts/at91sam9x5.dtsi   |    6 +
 arch/arm/boot/dts/at91sam9x5ek.dtsi |    4 +
 drivers/watchdog/at91sam9_wdt.c     |  287 ++++++++++++++---------------------
 include/linux/watchdog.h            |    8 +
 5 files changed, 137 insertions(+), 174 deletions(-)

-- 
1.7.9.5
