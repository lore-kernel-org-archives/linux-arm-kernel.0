From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Tue, 29 Nov 2016 17:47:12 -0600
Subject: question about irq_enter()/irq_exit() calling policy
Message-ID: <22d0d991-bbe2-ce10-5202-3cdf97a9ecf2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Sorry for the may be dumb question, but what is the calling policy for irq_enter()/irq_exit()?

1) Should these function be called each time system enter/exit IRQ context?

HW IRQ:
 switch (IRQ mode)
  ...
  irq_enter()
	handle irq - execute hw_irq_hadler
  irq_exit()
  ...
 switch

2) Should these function be called for each processed irq?


HW IRQ:
 switch (IRQ mode)
  ...
  while (irq = get_pending_irq()) {
  	...
  	irq_enter()
		handle(irq) - execute hw_irq_hadler
  	irq_exit()
 }
 ...
 switch

-- 
regards,
-grygorii
