From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Wed,  5 Dec 2012 09:34:19 +0800
Subject: [v2 PATCH 0/8] watchdog/at91sam9_wdt: Convert to use the new
 framework
Message-ID: <1354671267-19277-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, All

The purpose of the patch series is to convert to use the watchdog framework,
I tested it on at91sam9g25ek.

It is based on v3.7-rc8 + Fabio Porcedda's add device tree support 
				and add timeout-sec property binding

ChangeLog 
v2:
1./ Remove the patches to add devive tree support which Fabio Porcedda
	has done and submitted.

2./ Replace __raw_readl, __raw_writel with readl_relaxed, writel_relaxed.

3./ Rebase on v3.7-rc8.

Best Regards
Wenyou Yang

Wenyou Yang (8):
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

 arch/arm/boot/dts/at91sam9g25ek.dts |    4 +
 arch/arm/boot/dts/at91sam9n12.dtsi  |    6 +
 arch/arm/boot/dts/at91sam9x5.dtsi   |    6 +
 drivers/watchdog/at91sam9_wdt.c     |  288 ++++++++++++++---------------------
 4 files changed, 132 insertions(+), 172 deletions(-)

-- 
1.7.9.5
