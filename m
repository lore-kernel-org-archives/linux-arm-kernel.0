From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 10 Sep 2010 17:28:57 -0500
Subject: i.MX35 gpio troubles
Message-ID: <0D753D10438DA54287A00B02708426976444C4E59F@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

I'm having problems reading some of the gpio pins on an i.MX35 based system.  I have
verified that the pins "work" I just can't read them from userspace.

I am trying to use the upper 6-bits of the lcd port (LD18-23, GPIO3.24-29) as gpio.
I have them set in the struct pad_desc table as:

	MX35_PAD_LD18__GPIO3_24,
	MX35_PAD_LD19__GPIO3_25,
	MX35_PAD_LD20__GPIO3_26,
	MX35_PAD_LD21__GPIO3_27,
	MX35_PAD_LD22__GPIO3_28,
	MX35_PAD_LD23__GPIO3_29,

I have also verified that the relevant IOMUX registers are set correctly.

>From userspace I am using the sysfs interface to export the gpio's.  For instance
GPIO3.24 (LD18) is gpio88:

$ echo 88 > /sys/class/gpio/export
$ cat /sys/class/gpio/gpio88/direction
in
$ cat /sys/class/gpio/gpio88/value
0
$ echo out > /sys/class/gpio/gpio88/direction
$ cat /sys/class/gpio/gpio88/direction
out
$ cat /sys/class/gpio/gpio88/value
0
$ echo 1 > /sys/class/gpio/gpio88/value
$ cat /sys/class/gpio/gpio88/value
0

If I read the GPIO_PSR register I see that bit 24 is 0, but if I read the GPIO_DR
register I see that bit set correctly.  I can also probe the output signal and see
that it changes to the correct 'value'.

Any ideas?

Regards,
Hartley
