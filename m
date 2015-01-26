From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 26 Jan 2015 13:57:14 +0200
Subject: [PATCH v5 0/2] clocksource: Conexant CX92755 timers support
Message-ID: <cover.1422272518.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This short series adds support for the Conexant CX92755 SoC timers. This SoC is
part of the Conexant Digicolor series of SoCs.

v5:
   * Switch back to use of_iomap (not of_io_request_and_map), as the watchdog 
	 driver also needs access to the same registers; add a comment clarifying 
	 this

   Address more review comments by Daniel Lezcano:

   * Properly encapsulate the static objects for the clock_event code

   * Use dc_timer_{disable,enable,set_count} accessors to make the code clearer

v4:
   http://thread.gmane.org/gmane.linux.kernel/1874017

   Address review comments by Daniel Lezcano:

   * Use macros for register configuration values

   * Encapsulate static objects in a struct

   * Use of_io_request_and_map to exclusively map registers

   * Use UINT_MAX instead of ~0

   * Use request_irq instead of setup_irq, obviating the need for a separate 
     irqaction struct

v3:
   http://article.gmane.org/gmane.linux.kernel/1870628
   http://article.gmane.org/gmane.linux.kernel/1870627

   * Split into a separate clocksource series

v2:
   http://article.gmane.org/gmane.linux.kernel/1861850
   http://article.gmane.org/gmane.linux.kernel/1861853

   * Change the timer dt binding, so that the 'reg' property points to the
     first "Agent Communication" register. This should improve the chance of
     reusing this binding for other SoCs in this series.

   * Add the CONTROL() and COUNT() macros to the timer driver to make the code
     clearer.

   * Move arch/arm Kconfig changes from the clocksource driver patch to the
     base arch support patch to reduce dependency between them

v1:
   http://article.gmane.org/gmane.linux.kernel/1855028
   http://article.gmane.org/gmane.linux.kernel/1855025

Baruch Siach (2):
  clocksource: devicetree: document Conexant Digicolor timer binding
  clocksource: driver for Conexant Digicolor SoC timer

 .../devicetree/bindings/timer/digicolor-timer.txt  |  18 ++
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/timer-digicolor.c              | 199 +++++++++++++++++++++
 3 files changed, 218 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/digicolor-timer.txt
 create mode 100644 drivers/clocksource/timer-digicolor.c

-- 
2.1.4
