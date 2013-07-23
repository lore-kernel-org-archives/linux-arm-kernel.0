From: simon.guinot@sequanux.org (Simon Guinot)
Date: Tue, 23 Jul 2013 17:18:34 +0200
Subject: Location for a kind of GPIO bus driver
Message-ID: <20130723151834.GJ9916@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am currently working on converting the LED driver leds-netxbig to DT.
Doing so, I am also considering to move the GPIO extension bus functions
(which are currently parts of leds-netxbig) into a separate driver.

On the LaCie "Big Network" board family (netxbig), the LEDs are
controlled by a CPLD. In turn, the CPLD can be configured (mostly the
LEDs modes) through a kind of parallel GPIO bus, called GPIO extension
bus. Two registers (address and data) are exposed. Each of them is made
up of several GPIOs. An extra GPIO is used to notify the CPLD that the
registers have been updated. The leds-netxbig driver uses some dedicated
functions (prefixed by "gpio_ext_") to handle the GPIO bus extension.

On the latest "Big Network" boards, this bus is also used to enable the
PM wakeup sources: the CPLD can be asked to keep powered some devices
(as the RTC or the Ethernet PHY) while the board is down. I think it
could be nice to expose this feature to the userland. That's why I am
thinking about moving the GPIO extension bus support into a separate
driver. The problem is that I can't find a proper location for a such
driver. AFAIK, it doesn't fit with anything existing supported by Linux.
Maybe I should consider drivers/bus ? Or even drivers/misc ?

Also from a DT point, it not clear to me how the resulting bus and LEDs
driver are going to work together.

Any advice is welcome. Thanks in advance.

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130723/14d4cf33/attachment.sig>
