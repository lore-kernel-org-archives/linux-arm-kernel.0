From: judith.baumgarten@tu-cottbus.de (Judith Baumgarten)
Date: Thu, 14 Jan 2010 11:52:25 +0100
Subject: pxa320: change uart configuration
In-Reply-To: <20100112173606.GF5633@n2100.arm.linux.org.uk>
References: <20100112183000.14575jy4enpsv6ag@webmail.tu-cottbus.de>
	<20100112173606.GF5633@n2100.arm.linux.org.uk>
Message-ID: <20100114115225.94334g603pqhe1d5@webmail.tu-cottbus.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Zitat von Russell King - ARM Linux <linux@arm.linux.org.uk>:

> On Tue, Jan 12, 2010 at 06:30:00PM +0100, Judith Baumgarten wrote:
>> I want to change the uart configuration of the pxa serial ports in order
>> to be able to connect to different devices. The problem is, that it jumps
>> back to its initial configuration, when it receives some data. I used
>> stty of busybox 1.14.3 as well as the termios-structure to change the
>> configuration, but it always remained the same. I could protect some
>> configurations by using the TIOCSLCKTRMIOS ioctl, but the baudrate still
>> jumps back.
>
> Something will be changing it back.  A getty maybe?

We have no getty on our system. Inittab contains just the following entries:

::sysinit:/etc/init.d/rcS
ttyS0::respawn:-/bin/sh
ttyS1::respawn:-/bin/sh
tty1::respawn:-/bin/sh
tty2::respawn:-/bin/sh
::ctrlaltdel:/bin/umount -a -r

and a "ps ax | grep tty" has no result.

----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.
