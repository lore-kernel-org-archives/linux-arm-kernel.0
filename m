From: jjo.braun@gmail.com (Johannes Braun)
Date: Fri, 3 May 2013 13:56:00 +0200
Subject: Freescale imx35: sgtl5000 codec not working over i2c
In-Reply-To: <20130503093948.GT32299@pengutronix.de>
References: <20130502200024.72c112cc@jobraun>
 <20130502181821.GC31135@pengutronix.de>
 <20130502204020.0462f080@jobraun>
 <20130503093948.GT32299@pengutronix.de>
Message-ID: <CADwvPCtK_4gMHggP0mN2yqCLHzFY7EC9EnK8CpEHr87E=pkMPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> With "sgtl5000" at least sgtl5000_i2c_probe should be called.

Ok my fault. I did not see the i2c probe mehtod. I checked whether
sgtl5000_i2c_probe is called or not and I can confirm that the method
was passed successfully. I tested it with several kernel log messages.

> Is the i.MX I2C driver registered correctly. What's in /sys/bus/i2c/devices/?

I think so. The following devices are shown:
ls -la /sys/bus/i2c/devices/
lrwxrwxrwx 1 root root 0 Jan  1  1970 0-000a ->
../../../devices/platform/imx-i2c.0/i2c-0/0-000a/
lrwxrwxrwx 1 root root 0 Jan  1  1970 i2c-0 ->
../../../devices/platform/imx-i2c.0/i2c-0/
lrwxrwxrwx 1 root root 0 Jan  1  1970 i2c-2 ->
../../../devices/platform/imx-i2c.2/i2c-2/

Also I am able to probe the bus via i2cdetect. This is the result:
root at generic-armv6:~$ i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- UU -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --

UU shows that this device is use by a driver.

> you won't need much more than something similar to
> arch/arm/mach-imx/imx25-dt.c and an auxdata table for the clock lookups.
> There even is pinctrl support.

I will check this out.

---
Johannes
