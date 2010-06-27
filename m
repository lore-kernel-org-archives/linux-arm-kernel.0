From: mishal@softerra.com (Mykhail Lodygin)
Date: Sun, 27 Jun 2010 23:09:55 +0300
Subject: Using SPI in a kernel module
In-Reply-To: <419523.332.qm@web33805.mail.mud.yahoo.com>
References: <419523.332.qm@web33805.mail.mud.yahoo.com>
Message-ID: <4C27B013.4010400@softerra.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello
How about specifying correct data (for your particular board) in the 
machine-specific code?(arch/your_arch/mach-your_machine/your_machine.c)
Basically it is enough for the system to invoke proper probes.
Mikhail
On 06/27/2010 09:25 PM, Alfredo Quesada S?nchez wrote:
> After reading many things about SPI in linux (including the kernel Documentation, that is, spi_summary.txt) and having read many source files in the kernel itself I'm not sure which is the right way to deal with SPI from a kernel module if you don't want to use the spidev (neither the spi-gpio) implementation.
>
> My goal is to create an spidev-like module, which generates a /dev entry (that is the easy part) and hides the details of the device, such as an EEPROM. The way to communicate with userspace using /dev files is simple, but the access to spi.h features isn't that much.
>
> According to some board specific code there is one spi device registered in the system (it's wired to a serial dataflash in my development board), but I don't know how I can get a reference to the spi_device that should give me access to it.
>
> By looking to other existing drivers I should register my own spi_driver, mostly providing probe and remove functions. And the questions are:
> - When should I receive a probe call?
> - What if I have more than 1 spi device on my system (let's say.. 3)? Will I receive 3 calls to probe?
> - Is this the only way to get valid references to spi_device's? Is there any other way to access to the "list" of available spi_device's?
>
> I did a small test with a fake module, which registers a spi_driver, but I did not receive any probe call, that's why this might not be the right way to access to the spi_device.
> Besides in other low level code I can see calls to
>
> Regards
>
>
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>    
