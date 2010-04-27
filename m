From: shubha1310@gmail.com (shubha)
Date: Tue, 27 Apr 2010 09:20:10 -0400
Subject: PPI interrupts on SMP
Message-ID: <z2zdeaa794d1004270620k381e2edbgbd6b368921dd3a82@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

I am working on an ARMV7 SMP system with GIC.  One of the subsystems uses a
peripheral interrupt that is local/private to each CPU core (PPI interrupt).
The interrupt number is same on all CPU cores.

The request_irq() call works for the first core the interrupt is requested
on, however on the second core that it tries to request, it fails with the
error "Unable to request IRQx for ARMv7".

Is there any solution to get this interrupt working? I noticed that other
similar private interrupts (timer, IPI) have special processing in
entry-armv.S


Thanks

Shubha
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100427/6c7d661e/attachment-0001.htm>
