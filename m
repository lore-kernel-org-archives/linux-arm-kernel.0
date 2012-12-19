From: m-karicheri2@ti.com (Murali Karicheri)
Date: Wed, 19 Dec 2012 18:06:43 -0500
Subject: RT-Preempt patched kernel - DaVinci SPI driver IRQ handler not getting
 called
Message-ID: <50D24883.9010509@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

We have applied the RT-Preempt patch on top of the 3.6.6 Linux kernel 
and getting an issue with DaVinci SPI driver. During the probing of SPI 
NOR flash driver, the flash driver (slave) sends a command and the 
response is not received by the spi interrupt handler. The IRQ is 
delivered to the interrupt controller driver and is finally delivered to 
the irq_thread (called irq_wakeup_process()), but the thread doesn't 
seem to wake up and hence the irq is not delivered to the driver 
handler. When I add a flag IRQF_NO_THREAD to the irq flags as part of 
request_irq(), the driver handler is getting called. DId someone see 
similar behavior on any DaVinci or any other ARM platform? Any 
suggestions as to how to debug this?

Thanks

Murali Karicheri
