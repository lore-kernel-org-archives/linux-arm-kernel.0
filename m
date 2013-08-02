From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 2 Aug 2013 10:46:50 +0200
Subject: NSA310 + DT
In-Reply-To: <51FB6F59.4010205@uni-bremen.de>
References: <20130710073706.GA28212@lunn.ch> <51F6A0DC.3020501@uni-bremen.de>
 <20130729192112.GY29916@titan.lakedaemon.net>
 <20130729204315.GK24782@lunn.ch> <51F78DA6.8010307@uni-bremen.de>
 <20130730144752.GR24782@lunn.ch> <20130730172407.3aab15c6@skate>
 <51F7EBB9.7000504@uni-bremen.de> <20130730191943.49f8070c@skate>
 <20130730183610.GT24782@lunn.ch> <51F814A0.2050403@uni-bremen.de>
 <20130730232316.10dc7019@skate> <20130731111414.47e7670b@skate>
 <51F8DC3A.6010007@uni-bremen.de> <20130731115108.21c043fd@skate>
 <51FB6F59.4010205@uni-bremen.de>
Message-ID: <20130802104650.68a13327@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Finn Hoffmann,

On Fri, 02 Aug 2013 10:35:37 +0200, Finn Hoffmann wrote:

> I just came across one thing. Is it ok that I have different Marvell 
> device with patched 3.11.0-rc3?
> With 3.10.2 it has pci id 11ab:6281, with 3.11.0-rc3 and your patch it 
> has 11ab:7846.

Yes, this is expected. 3.11-rc uses a completely new PCI driver for
Marvell platforms, that has a proper Device Tree binding. This driver
uses a very different strategy than the old driver in terms of MBus
window configuration, and to achieve this it relies on an emulated
PCI-to-PCI bridge. The numbers you're seeing are the one of the
emulated PCI-to-PCI bridge.

And the patch I've done fixes this PCI-to-PCI bridge emulation. BTW,
I've officially submitted the patch, which has been taken by the PCI
maintainer and will be part of one of the next 3.11-rc, and therefore
of the final 3.11. I mentioned you as Reported-by and thought git
send-email would automatically Cc you on the patch, but it did not.

Thanks again for your report!

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
