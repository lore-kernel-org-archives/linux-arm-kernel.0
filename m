From: domenico.andreoli@linux.com (Domenico Andreoli)
Date: Sat, 14 Sep 2013 17:20:32 +0200
Subject: [PATCH v4 0/4] ARM: Broadcom BCM4760 support
Message-ID: <20130914152032.401907974@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

  here is the summary of the changes I made since v3:

* added low-level debug PL01X parameters
* added clocks to the VICs DT stanzas
* added bcm4760_readl/writel helpers to the system driver code and
  removed (my) previous (naive) helpers
* inverted the order of clockevents_config_and_register() and setup_irq()
  so to simplify the irq handler
* drop the clock frequency option from the DT (left-over form v2)
* moved the watchdog based implementation to drivers/watchdog

This patchset is not autonomous for the build of mach-bcm if ARCH_BCM
is not enabled, a detail that should get a fix from Christian soon.

In the meanwhile I post for kind review.

Best regards,
Domenico
