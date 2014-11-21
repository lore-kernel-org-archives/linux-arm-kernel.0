From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri, 21 Nov 2014 14:31:05 +0400
Subject: IRQ #0 broken on ARM
Message-ID: <CALT56yPs-SSssff1waj81CRQfER4ZKKR=B1jOXVL-aBChicSjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

After the commit a71b092a9c68685a270ebdde7b5986ba8787e575
(ARM: Convert handle_IRQ to use __handle_domain_irq) IRQ #0 is broken
on ARM. It is a valid IRQ and it is quite imporant (on sa1100 it's a GPIO0).

The worst thing is that the CPU will be stuck busy-looping around this IRQ
w/o printing anything to the console or masking the irq. How should we cope
with that? I'd like to propose to either revert the offending commit or to add
the following patch.

-- 
With best wishes
Dmitry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-genirq-handle-IRQ-0-in-__handle_domain_irq.patch
Type: text/x-patch
Size: 1159 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141121/4738271e/attachment.bin>
