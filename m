From: ariel@vanguardiasur.com.ar (Ariel D'Alessandro)
Date: Wed,  1 Jul 2015 17:52:08 -0300
Subject: [PATCH v2 0/2] Add support for NXP LPC18xx Watchdog timer
Message-ID: <1435783930-20184-1-git-send-email-ariel@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for the watchdog timer found in NXP LPC
SoCs family which includes LPC18xx/LPC43xx. Other SoCs in that family may
share the same watchdog hardware.

Patchset is based on tag next-20150624 of the linux-next repository.
It has been successfully tested on a Hitex LPC4350 Evaluation Board and
on a CIAA NXP LPC4337 Board.

Changes since v1:
* Dropped "Windowed" term in Watchdog's name.
* Changed default timeout value from 1 to 5 because it was too tight.
* Fixed module remove function, since it was keeping the timer enabled. Warning
  message was added.
* Changed dt compatible string to "nxp,lpc1850-wdt".
* Renamed clocks matching most of the other lpc18xx drivers.

Ariel D'Alessandro (2):
  watchdog: NXP LPC18xx Watchdog Timer Driver
  DT: watchdog: Add NXP LPC18xx Watchdog Timer binding documentation

 .../devicetree/bindings/watchdog/lpc18xx-wdt.txt   |  19 ++
 drivers/watchdog/Kconfig                           |  11 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/lpc18xx_wdt.c                     | 342 +++++++++++++++++++++
 4 files changed, 373 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/lpc18xx-wdt.txt
 create mode 100644 drivers/watchdog/lpc18xx_wdt.c

-- 
1.9.1
