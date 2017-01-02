From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Jan 2017 15:00:16 +0000
Subject: [PATCH 15/20] ARM/hw_breakpoint: Convert to hotplug state machine
In-Reply-To: <CACRpkda2gdjM--LSoJTL0dvqyw796w1hMSAhUQwv9X0EPzJHig@mail.gmail.com>
References: <20161117183541.8588-1-bigeasy@linutronix.de>
 <20161117183541.8588-16-bigeasy@linutronix.de>
 <CACRpkdZE+h0+3EizLCMUr-e-4pv4w9iAatSqL8k0Ovd2iUaS8Q@mail.gmail.com>
 <CACRpkda2gdjM--LSoJTL0dvqyw796w1hMSAhUQwv9X0EPzJHig@mail.gmail.com>
Message-ID: <20170102150015.GJ14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 02, 2017 at 03:34:32PM +0100, Linus Walleij wrote:
> in the first line of arch_hw_breakpoint_init() in
> arch/arm/kernel/hw_breakpoint.c
> 
> I suspect that is not an accepable solution ...
> 
> It hangs at PC is at write_wb_reg+0x20c/0x330
> Which is c03101dc, and looks like this in objdump -d:
> 
> c031020c:       ee001eba        mcr     14, 0, r1, cr0, cr10, {5}
> c0310210:       eaffffb3        b       c03100e4 <write_wb_reg+0x114>

... and this is several instructions after the address you mention above.
Presumably c03101dc is accessing a higher numbered register?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
