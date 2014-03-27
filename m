From: carlo@caione.org (Carlo Caione)
Date: Thu, 27 Mar 2014 18:02:37 +0100
Subject: [PATCH 0/2] ARM: sun7i/sun6i: Fix broken kernel on sun6i/A31
Message-ID: <1395939759-11135-1-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These fixes are proposed by Hans de Goede to fix the broken kernel on
sun6i/A31. The major problem is that the IRQ number for NMI on sun6i is wrong.
Besides that, Hans proposed a fix to avoid having sporious interrupts when the
NMI line is asserted but no driver has claimed the downstream interrupt of the
NMI.

Hans de Goede (2):
  ARM: sun7i/sun6i: dts: Fix IRQ number for sun6i NMI controller
  ARM: sun7i/sun6i: irqchip: Disable NMI before registering the handler

 arch/arm/boot/dts/sun6i-a31.dtsi | 2 +-
 drivers/irqchip/irq-sunxi-nmi.c  | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
1.8.4.1
