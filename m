From: bill4carson@gmail.com (bill4carson)
Date: Fri, 16 Sep 2011 14:13:34 +0800
Subject: Query about ARM interrupt virtualization
Message-ID: <4E72E90E.7060906@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, all

I have been doing ARM interrupt virtualization based on Christoffer KVM 
work.
Current status is an A15 guest os could boot successfully based on ARM KVM
without interrupt virtualization.


Interrupt injection is taken care of by Qemu, if interrupt 
virtualization need to be
supported, then all the gic cpu interface code in Qemu must be removed.
The distributor in Qemu figure out the best irq, then ship this best_irq 
into virtual
cpu interface through list register.

The problem is Distributor state must be synchronized with two cpu 
interface
actions: ACK(interrupt acknowledge) and EOI (end Of Interrupt).
EOI could be trapped by hypervisor, this will enable us to call 
gic_complete_irq
in Qemu to update Distributor state.
However for now I cannot find a way for ACK to be catch,
or am I missing something important here?

Any tips/suggestions would be appreciated!


bill
