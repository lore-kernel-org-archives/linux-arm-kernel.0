From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 31 Jul 2013 11:14:14 +0200
Subject: NSA310 + DT
In-Reply-To: <20130730232316.10dc7019@skate>
References: <20130710073706.GA28212@lunn.ch> <51F6A0DC.3020501@uni-bremen.de>
 <20130729192112.GY29916@titan.lakedaemon.net>
 <20130729204315.GK24782@lunn.ch> <51F78DA6.8010307@uni-bremen.de>
 <20130730144752.GR24782@lunn.ch> <20130730172407.3aab15c6@skate>
 <51F7EBB9.7000504@uni-bremen.de> <20130730191943.49f8070c@skate>
 <20130730183610.GT24782@lunn.ch> <51F814A0.2050403@uni-bremen.de>
 <20130730232316.10dc7019@skate>
Message-ID: <20130731111414.47e7670b@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Finn,

On Tue, 30 Jul 2013 23:23:16 +0200, Thomas Petazzoni wrote:

> Thanks for this log. I need a bit of time to analyze this with the
> PCI-to-PCI bridge specification, and I'll cook up a new patch,
> hopefully tomorrow.
> 
> Thanks again a lot for taking the time to report this bug and test the
> patches,

Ok, here is another patch that completely disables prefetchable
support, which hopefully should make the PCI stuff fallback on normal
memory. Could you try this one, and again report lspci -v + the
contents of the debugfs file that lists the mbus windows?

I've worked more on the prefetchable support, but doing it right with
the PCI-to-PCI bridge emulation is a bit complex.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-pci-mvebu-disable-prefetchable-memory-support.patch
Type: text/x-patch
Size: 1780 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130731/bce3bb46/attachment.bin>
