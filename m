From: wpdster@gmail.com (Patrick Doyle)
Date: Mon, 8 Aug 2016 15:56:49 -0400
Subject: How does the kernel assign ttySn to UARTs?
Message-ID: <CAF_dkJD5MEfNzrRqM3H_LkOmXC3XYjUYLe2=ZtzCjAS1A2TDmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am playing the the device tree for my (Atmel, SAMA5D2x) device and
find myself confused by the assignment of ttySn devices to UARTs and
FLEXCOM devices.

I started off assuming that the

    alias {
        serial0 = &uart2;
    };

stanza I put in my device tree resulted in ttyS0 being aliased to
uart2 (serial at f8024000).  But when I attempted to change the alias to
uart5 (the label for UART defined in flexcom at fc018000) I was surprised
and confused by the fact that the console continued to spew forth on
UART2.

So I tried removing the "alias" stanza from the device tree.  The
console still showed up on UART2.

I wondered if it might have something to do with the order that
devices show up in the device tree, so I swapped UART2 & UART3, but
the console still showed up on UART2.

Just to make sure I wasn't losing my mind, I decided to comment UART2
out completely... and then the console showed up on FLEXCOM4.  Not
UART3, but FLEXCOM4!

Now I'm really confused.  Now it is time to ask the experts.

FWIW, my kernel command line contains "console=ttyS0", while my device
tree enables UART2, UART3, and FLEXCOM4 (which us configured as a
UART).  Nowhere do I enable UART0, so I am also confused has to how
/dev/ttyS0 gets mapped to UART2 or FLEXCOM4.

Would any experts out there care to point me in the direction of some clues?

Thanks.

--wpd
