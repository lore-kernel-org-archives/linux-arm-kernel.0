From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 18 Jun 2013 15:51:34 +0200
Subject: Marvell SoCs: is register remapping to 0xf1NNNNNN safe?
In-Reply-To: <20130618134220.GY2718@n2100.arm.linux.org.uk>
References: <20130618134220.GY2718@n2100.arm.linux.org.uk>
Message-ID: <20130618135134.GB14346@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 02:42:20PM +0100, Russell King - ARM Linux wrote:
> On the Armada 510, like most mvebu platforms, the registers are remapped
> to 0xf1NNNNNN.  This means things like the ATA interfaces are at
> 0xf10a0000, SPI at 0xf1010600 etc.
> 
> It also means that the global config 1 register is at 0xf10e802c.  Other
> registers live at 0xf10e0000, 0xf10e4000, etc.
> 
> Now, if I access any register in the 0xf10eNNNN, whether it be the global
> configuration register, a GPIO register, AC'97 register, the result is an
> instant and solid hang - presumably the bus locks up.  It doesn't matter
> if it is accessed in an interrupt-protected region, preempt-disabled
> region, or via a userspace mapping of that memory, the result is always
> the same, and things like sysrq don't work.
> 
> Only a watchdog or power cycle recovers the SoC (presumably also a hardware
> reset too, but I can't test that.)
> 
> Any ideas?  Can this behaviour be replicated on any other of these SoCs?

Hi Russell

Kirkwood, and some of the other SoCs, will hang if the clock for the
IP block is not ticking.

   Andrew
