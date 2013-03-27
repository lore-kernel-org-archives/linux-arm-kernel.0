From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 27 Mar 2013 19:18:50 +0100
Subject: [RFC PATCHv1 0/5] Use the mvebu PCIe driver on Kirkwood
In-Reply-To: <20130327191114.2662b3b8@skate>
References: <1364407504-13524-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201303271807.51023.arnd@arndb.de> <20130327191114.2662b3b8@skate>
Message-ID: <20130327191850.26ab1623@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On Wed, 27 Mar 2013 19:11:14 +0100, Thomas Petazzoni wrote:

> > I assume it works with PIO, but does the SATA card use the I/O
> > space registers, or just memory space?
> 
> Both cards only use memory space. I have a quick and dirty patch for
> the e1000e driver that makes it read/write one particular register from
> the I/O space to test that it works, but I haven't checked this yet on
> Kirkwood. I don't expect much troubles, but who knows.

Just to let you know, I've tested the e1000e with my small changes that
does one I/O access, and it seems to work properly. At least, I read
from the register the value I should be reading (and therefore writing
works, because the I/O space of the e1000e essentially has two
registers: one address register, and one data register, so you must
write one address in the address register before being able to read
something from the data register).

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
