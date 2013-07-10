From: tibor@harsszegi.com (tibor at harsszegi.com)
Date: Wed, 10 Jul 2013 03:01:22 +0200
Subject: NSA310 + DT
In-Reply-To: <20130709193605.GC26223@lunn.ch>
References: <51DC564A.8050002@harsszegi.com> <20130709193605.GC26223@lunn.ch>
Message-ID: <1a9bcb9094ae695c6707c4835417dd5b@harsszegi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello guys,

> A basic question to start with. Are you using the default kernel
> configuration for kirkwood? Which kernel version are you using?
> 

standard kernels, have been trying 3.9.8,3.9.9 and 3.10

> Do you know what address it is using on the i2c bus? It looks like it
> would be one of: 0x2c, 0x2d, 0x2e. Does you board also have the
> adt7476?

The address is the same as the adt ones' but it is
recognized as a lm85. Sorry was a bit misleading. I could
make my sensors work via simply changing the type
from adt7476 to lm85

> b.) uart0 is not recognized at all during boot, I cannot see that
> 8250 would recognize the UART at the mmaped area, however the .DTS
> config seems fine
> 
> Do you see anything like:
> 
> Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
> f1012000.serial: ttyS0 at MMIO 0xf1012000 (irq = 33) is a 16550A
> console [ttyS0] enabled
> f1012100.serial: ttyS1 at MMIO 0xf1012100 (irq = 34) is a 16550A
> 

None at all. I only see the first "Serial:" line, then
nothing else, seems like the UART0 is stucked, badly mapped/initialized
at that time.

> c.) LEDs are also not working, this is also strange, as the .DTS
> seems to be just fine as well.
> 
> How do you mean not working? Is /sys/class/leds/ empty? Or when you
> change the brightness value, nothing happens?
> 
Sorry lame me, wasn't clear again :)
All the LEDs remain "uninitialized", all
remains green after bootup, haven't tried setting
them yet :(

Cheers,
Tibor
