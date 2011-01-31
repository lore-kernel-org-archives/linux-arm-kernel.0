From: jsolla@bitnia.com (Jorge Solla)
Date: Mon, 31 Jan 2011 14:49:25 +0100
Subject: AT91SAM9260. Supported hardware questions.
Message-ID: <AANLkTimq=1f=bdFJ7+11mdN7f8GD10JHxcf-mWr3za-a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello:

 I'm planning to build a new board based on the ATMEL AT91SAM9260 processor,
but before doing it so, i would like to
confirm several issues:

SDIO Support:

 I would like to integrate a SDIO Wifi module (marvel 8686, atheros or any
other SDIO module). I'm unable to find
any conclusive information regarding this matter. There are several posts on
forums and mailing lists from people
trying it and getting only partial success (slow performance, errors, etc).

Question: Is the SDIO stack properly supported on this SoC?
Question: Can somebody confirm if SDIO+WIFI is properly working with this
kind of WIFI modules on AT91SAM9260?

GPIO Support:

  I'm aware of the existence of a kind of GPIO subsystem on the kernel
(linux/gpio.h) documented on "gpio.txt"
file. I know i can use /dev/mem to access the hardware registers, but a
ready-made API would help a lot.

Questions: Are the GPIO pins on the 9260 integrated on this kernel GPIO
subsystem? Or do i have to provide my own
GPIO driver to allow user-land applications using GPIO, or just use
/dev/mem?


ADC Support:

 I would like to be able to use the ADC on the 9260. I've seen several posts
on forums using an ADC driver
from ATMEL, but again nothing conclusive.

Question: Is this ADC driver available on the mainline kernel?


FLASH Support:

 I'm planning to use at least 1GB NAND on my board, but it's difficult to
find reference designs using one.
Question: Any warnings here...? Source code reference or something to start
with? Problems booting? Do i have
 to provide a serial dataflash for booting? or the NAND is just enough?



Any "BE AWARE OF.."

 Some time ago (years) i faced problems with a RM9200 based board having
issues with hardware SPI and
with lack of support for the RTC, and some others things that consumed lots
of time with software
work-arounds,etc..  I ended up using a bit-bang driver for the dataflash on
those days.

Question: Are there any "erratas" or bad-supported things that must be taken
into account before starting
the hardware desing of a new board?

Regards,
Jorge.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110131/89414489/attachment.html>
