From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 10 Jul 2013 09:37:06 +0200
Subject: NSA310 + DT
In-Reply-To: <1a9bcb9094ae695c6707c4835417dd5b@harsszegi.com>
References: <51DC564A.8050002@harsszegi.com> <20130709193605.GC26223@lunn.ch>
 <1a9bcb9094ae695c6707c4835417dd5b@harsszegi.com>
Message-ID: <20130710073706.GA28212@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >b.) uart0 is not recognized at all during boot, I cannot see that
> >8250 would recognize the UART at the mmaped area, however the .DTS
> >config seems fine
> >
> >Do you see anything like:
> >
> >Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
> >f1012000.serial: ttyS0 at MMIO 0xf1012000 (irq = 33) is a 16550A
> >console [ttyS0] enabled
> >f1012100.serial: ttyS1 at MMIO 0xf1012100 (irq = 34) is a 16550A
> >
> 
> None at all. I only see the first "Serial:" line, then
> nothing else, seems like the UART0 is stucked, badly mapped/initialized
> at that time.

This suggests you are missing SERIAL_OF_PLATFORM.

Try

make kirkwood_defconfig
make

and see if that kernel works any better.

> >c.) LEDs are also not working, this is also strange, as the .DTS
> >seems to be just fine as well.
> >
> >How do you mean not working? Is /sys/class/leds/ empty? Or when you
> >change the brightness value, nothing happens?
> >
> Sorry lame me, wasn't clear again :)
> All the LEDs remain "uninitialized", all
> remains green after bootup, haven't tried setting
> them yet :(

Looking through the patch you pointed out, i think you will find some
work, some don't, and some have the wrong meaning.

We are going to need to add a new DTS file for this board. I can work
on this soon.

   Andrew
