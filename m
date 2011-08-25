From: joravec@drewtech.com (Joey Oravec)
Date: Thu, 25 Aug 2011 17:28:25 -0400
Subject: kernel driver for rs232 serial peripheral
Message-ID: <4E56BE79.4030103@drewtech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fellow ARM developers,

We make a multi-function chip (rtc, gpio, nvram, etc) for embedded 
applications that has an rs232 serial interface. My goal is to write an 
MFD kernel driver that speaks serial to this device and implements 
interfaces. Other busses like spi and i2c are pretty straightforward in 
the kernel but serial feels a lot more complicated. To talk to this 
device from the kernel it seems like I need to:

- Call tty_register_ldisc to create a line discipline
- Call tty_register_driver and setup a driver
- Require userspace to call setserial and change the line discipline

This might work, but the documentation implies that a line discipline is 
for a protocol, not for connecting a device driver to a serial port. Is 
there any kind of easier-to-use serial class similar to i2c or spi where 
I can just setup a platform device/driver on a specific serial port? Am 
I missing an easier solution?

-joey
