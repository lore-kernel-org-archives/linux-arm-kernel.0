From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 21 Oct 2016 15:11:36 +0200
Subject: gpio: mxs: fix duplicate level interrupts
Message-ID: <20161021131138.10467-1-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We observed that each level interrupt triggers two interrupts. This
is because the driver erroneously uses the IRQSTAT register to 
acknowledge level interrupts which according to the reference manual
is not possible. Patch 2/2 fixes that, look for its commit message
for a detailed description what happens and how it is fixed.

Sascha

----------------------------------------------------------------
Sascha Hauer (2):
      gpio: mxs: use enable/disable regs to (un)mask irqs
      gpio: mxs: fix duplicate level interrupts
