From: michael@dinsnail.net (Michael Weiser)
Date: Fri, 28 Aug 2015 17:58:26 +0200
Subject: no booting due to handle_domain_irq on orion5x/kurobox
Message-ID: <20150828155826.GD2776@dinsnail.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I've got vanilla kernels running on a Buffalo Linkstation Pro
(orion5x/Kurobox Pro). The last release kernel to work is 3.17.8.
Anything after that just says "Uncompressing Linux... Ok. booting the
kernel" and stops. 

By building and booting various intermediate stages from git, I've
narrowed it down to the following three commits:

76ba59f8366f2d9282cb5bda9de75b4b68cbe55f genirq: Add irq_domain-aware core IRQ handler
a71b092a9c68685a270ebdde7b5986ba8787e575 ARM: Convert handle_IRQ to use __handle_domain_irq
f4bc9288b4a29ead48425dd7d1bf4b825a8aff58 irqchip: orion: Convert to handle_domain_irq

If I revert those from an otherwise unmodified current
torvalds/linux.git HEAD it boots up just fine.

I'm afraid that's as far as my kernel debugging know-how will take me.
Any help in how to proceed further in order to get current kernels
running on my box would be highly appreciated.
-- 
Thanks,
Michael
