From: dgilbert@interlog.com (Douglas Gilbert)
Date: Fri, 09 Nov 2012 11:58:21 -0500
Subject: [PATCH] atmel_serial oops when peripheral clock misconfigured
Message-ID: <509D362D.3040605@interlog.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In lk 3.7.0-rc4 when a peripheral clock is not found for
a serial port the atmel_serial driver brings down the
kernel with an oops during boot-up. This impacts the
Atmel AT91 family of MCUs.

For example, arch/arm/mach-at91/at91sam9x5.c does not
specify properly the peripheral clocks for the UTXD0/URXD0
and UTXD1/URXD1 serial ports. Selecting either of those
ports in a dts file will crash the kernel. at91sam9x5.c needs
to be fixed but stopping atmel_serial crashing the kernel is
more urgent.

Patch attached for your consideration.

Signed-of-by: Douglas Gilbert <dgilbert@interlog.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: atmel_serial_clk_oops.patch
Type: text/x-patch
Size: 2246 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121109/d24da5e3/attachment.bin>
