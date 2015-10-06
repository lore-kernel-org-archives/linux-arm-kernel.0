From: bharatku@xilinx.com (bharat kumar gogada)
Date: Tue, 6 Oct 2015 10:17:11 +0000 (UTC)
Subject: ARM64 PCIe legacy interrupts
References: <loom.20151001T142318-555@post.gmane.org>
 <CAHM4w1kzt0wCCxfvofXqzgK=Te50_1ZsYnApbEojMQq8x+wcdA@mail.gmail.com>
Message-ID: <loom.20151006T121259-647@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pratyush Anand <pratyush.anand <at> gmail.com> writes:

> 
> On Thu, Oct 1, 2015 at 5:59 PM, bharat kumar gogada <bharatku <at>
xilinx.com> wrote:
> > Hi, in ARM32 bit pci_fixup_irqs is being used to support legacy interrupts,
> > in ARM64 how legacy interrupts are being handled
> 
> See, arch/arm64/kernel/pci.c:pcibios_add_devices()
> 

Thanks.

I have a confusion in handling legacy interrupts in driver, I'm seeing that
for legacy handling there is separate node being created. Ex: for
pcie-xilinx.c the following node is being used

pcie_intc: interrupt-controller {
                        interrupt-controller;
                        #address-cells = <0>;
                        #interrupt-cells = <1>;
                };

Why do we need a separate child node for legacy handling and why is the
address cells parameter assigned zero value
