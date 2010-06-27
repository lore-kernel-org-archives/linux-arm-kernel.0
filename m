From: freddy2_es@yahoo.com (=?iso-8859-1?Q?Alfredo_Quesada_S=E1nchez?=)
Date: Sun, 27 Jun 2010 11:25:34 -0700 (PDT)
Subject: Using SPI in a kernel module
Message-ID: <419523.332.qm@web33805.mail.mud.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After reading many things about SPI in linux (including the kernel Documentation, that is, spi_summary.txt) and having read many source files in the kernel itself I'm not sure which is the right way to deal with SPI from a kernel module if you don't want to use the spidev (neither the spi-gpio) implementation.

My goal is to create an spidev-like module, which generates a /dev entry (that is the easy part) and hides the details of the device, such as an EEPROM. The way to communicate with userspace using /dev files is simple, but the access to spi.h features isn't that much.

According to some board specific code there is one spi device registered in the system (it's wired to a serial dataflash in my development board), but I don't know how I can get a reference to the spi_device that should give me access to it.

By looking to other existing drivers I should register my own spi_driver, mostly providing probe and remove functions. And the questions are:
- When should I receive a probe call?
- What if I have more than 1 spi device on my system (let's say.. 3)? Will I receive 3 calls to probe?
- Is this the only way to get valid references to spi_device's? Is there any other way to access to the "list" of available spi_device's?

I did a small test with a fake module, which registers a spi_driver, but I did not receive any probe call, that's why this might not be the right way to access to the spi_device.
Besides in other low level code I can see calls to 

Regards



      
