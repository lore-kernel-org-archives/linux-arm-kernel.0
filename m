From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Wed, 27 Nov 2013 14:48:23 +0200
Subject: [PATCH v4 0/5] Update Davinci watchdog driver
Message-ID: <1385556508-3935-1-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches are intended to update Davinci watchdog to use WDT core
and reuse driver for keystone arch, because Keystone uses the similar
IP like Davinci.

See Documentation:
Davinci DM646x - http://www.ti.com/lit/ug/spruer5b/spruer5b.pdf
Keystone - http://www.ti.com/lit/ug/sprugv5a/sprugv5a.pdf

Also:
 - improved to support GET_TIMELEFT option.
 - added "clocks" and "timeout-sec" properties to DT.

Based on
git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git
keystone/master

v3..v4:
- watchdog: davinci: change driver to use WDT core
	reverted rename of platform driver to "davinci-wdt"
	as it causes a regression on Davinci platforms.

- arm: dts: keystone: add watchdog entry
	The patch will be sent separately after series is ready.

v2..v3:
- watchdog: davinci: change driver to use WDT core
	removed "ti,keystone-wdt" compatible from driver
	renamed wdt device names for mach-davinci from
		"watchdog" to "davinci-wdt"

- watchdog: davinci: reuse driver for keystone arch
	moved "clocks" property under "Optional properties"
	improved description of "clocks" property

- arm: dts: keystone: add watchdog entry
	replaced "ti,keystone-wdt" compatible on
		 "ti,keystone-wdt","ti,davinci-wdt"

v1..v2:
- watchdog: davinci: change driver to use WDT core
	corrected 2011 -> 2006-2013
	removed useless function comment
	corrected initialization of heartbeat
	switched on CONFIG_WATCHDOG_NOWAYOUT option

- watchdog: davinci: use davinci_wdt_device structure to hold device data
	substituted wdd to watchdog device in commit message

- watchdog: davinci: add GET_TIMELEFT option support
	corrected comment (is -> has)
	removed redundant error message "clock freq is not set"

- watchdog: davinci: add GET_STATUS option support
	dropped

- watchdog: davinci: add "timeout-sec" property
	use consistent formatting

- watchdog: davinci: reuse driver for keystone arch
	use consistent formatting

- watchdog: davinci: add "clocks" property
	merged with above patch

Ivan Khoronzhuk (5):
  watchdog: davinci: change driver to use WDT core
  watchdog: davinci: use davinci_wdt_device structure to hold device
    data
  watchdog: davinci: add GET_TIMELEFT option support
  watchdog: davinci: add "timeout-sec" property
  watchdog: davinci: reuse driver for keystone arch

 .../devicetree/bindings/watchdog/davinci-wdt.txt   |   16 +-
 drivers/watchdog/Kconfig                           |    6 +-
 drivers/watchdog/davinci_wdt.c                     |  221 +++++++++-----------
 3 files changed, 114 insertions(+), 129 deletions(-)

-- 
1.7.9.5
