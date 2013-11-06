From: ivan.khoronzhuk@ti.com (ivan.khoronzhuk)
Date: Wed, 6 Nov 2013 13:30:18 +0200
Subject: Fwd: [PATCH 0/8] Update Davinci watchdog driver
In-Reply-To: <1383680783-12114-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1383680783-12114-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <527A284A.8000901@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches are intended to update Davinci watchdog to use WDT core
and reuse driver for keystone arch, because Keystone uses the similar
IP like Davinci.

See Documentation:
Davinci DM646x - http://www.ti.com/lit/ug/spruer5b/spruer5b.pdf
Keystone - http://www.ti.com/lit/ug/sprugv5a/sprugv5a.pdf

Also:
 - improved to support GET_TIMELEFT and GET_STATUS options.
 - added "clocks" and "timeout-sec" properties to DT.

Based on
git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git
keystone/master

TO:
Santosh Shilimkar <santosh.shilimkar@ti.com> (maintainer: TI KEYSTONE MACHIN...)
Wim Van Sebroeck <wim@iguana.be> (maintainer:WATCHDOG DEVICE D...)
Sekhar Nori <nsekhar@ti.com> (supporter:TI DAVINCI MACHIN...)
linux-watchdog at vger.kernel.org (open list:WATCHDOG DEVICE D...)
devicetree at vger.kernel.org (open list:OPEN FIRMWARE AND...)

CC:
Grant Likely <grant.likely@linaro.org> (maintainer:OPEN FIRMWARE AND...)
Rob Herring <rob.herring@calxeda.com> (maintainer:OPEN FIRMWARE AND...)
Pawel Moll <pawel.moll@arm.com> (maintainer:OPEN FIRMWARE AND...)
Mark Rutland <mark.rutland@arm.com> (maintainer:OPEN FIRMWARE AND...)
Stephen Warren <swarren@wwwdotorg.org> (maintainer:OPEN FIRMWARE AND...)
Kumar Gala <galak@kernel.crashing.org>
Ian Campbell <ijc+devicetree@hellion.org.uk> (maintainer:OPEN FIRMWARE AND...)
linux-kernel at vger.kernel.org (open list)
linux-arm-kernel at lists.infradead.org (moderated list:ARM SUB-ARCHITECT...)

Ivan Khoronzhuk (8):
  watchdog: davinci: change driver to use WDT core
  watchdog: davinci: use davinci_wdt_device structure to hold device
    data
  watchdog: davinci: add GET_TIMELEFT option support
  watchdog: davinci: add GET_STATUS option support
  watchdog: davinci: add "timeout-sec" property
  watchdog: davinci: reuse driver for keystone arch
  watchdog: davinci: add "clocks" property
  arm: dts: keystone: add watchdog entry

 .../devicetree/bindings/watchdog/davinci-wdt.txt   |   21 +-
 arch/arm/boot/dts/keystone.dts                     |    6 +
 drivers/watchdog/Kconfig                           |    5 +-
 drivers/watchdog/davinci_wdt.c                     |  234 ++++++++++----------
 4 files changed, 139 insertions(+), 127 deletions(-)

-- 
1.7.9.5
