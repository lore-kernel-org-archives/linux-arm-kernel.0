From: gururaja.hebbar@ti.com (Hebbar Gururaja)
Date: Fri, 31 May 2013 12:03:23 +0530
Subject: [PATCH 0/2] rtc: rtc-omap: add support for DT wakeup & alarm events
Message-ID: <1369982005-8572-1-git-send-email-gururaja.hebbar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current rtc-omap driver expects the rtc module wake-up capabilities to
be set up by board specific code. However, in case of DT, this is not
possible.

So, add a DT property "ti,wakeup_capable" to indicate that the module
is wake-up capable.

Also, on some platforms (like AM33xx), a special register
(RTC_IRQWAKEEN) is available to enable Wakeup feature for Alarm Events.

Since new platforms/Boards are now added through DT only, this feature
is supported via DT property only. Platforms using such IP should add
the property "ti,has_irq_wake_enb" in rtc DT node.

Kernel Base for the series is
	> git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/
linux-omap-dt.git
	> linux-omap-git/for_3.11/dts

Hebbar Gururaja (2):
  rtc: omap: add option to indicate wakeup support through DT
  rtc: omap: add rtc wakeup support to alarm events

 Documentation/devicetree/bindings/rtc/rtc-omap.txt |    6 +++
 drivers/rtc/rtc-omap.c                             |   50 +++++++++++++++++---
 2 files changed, 49 insertions(+), 7 deletions(-)

-- 
1.7.9.5
