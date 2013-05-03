From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 03 May 2013 21:38:07 +0200
Subject: [PATCH 9/9] ARM: ux500: always select ABX500_CORE
In-Reply-To: <CACRpkdaUKM1VzDhi3dMRh92XAYgg3KynvdmXKvCLfiCachP1EQ@mail.gmail.com>
References: <1367528578-518090-1-git-send-email-arnd@arndb.de>
 <2812721.61fsxKBgRj@wuerfel>
 <CACRpkdaUKM1VzDhi3dMRh92XAYgg3KynvdmXKvCLfiCachP1EQ@mail.gmail.com>
Message-ID: <1448676.shCqS631GB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 03 May 2013 20:43:42 Linus Walleij wrote:
> 
> Sounds like a deal. The AB chips aren't on-chip though
> they sit on I2C or SPI actually. But they are still
> strongly coupled with the SoC.
> 
> I just took a stroll around the premises and found this
> Aardvark I2C/SPI "embedded systems interface".
> 
> This is a USB thing that makes it possible to connect
> any I2C or SPI peripheral to the desktop ... I don't know how
> such things should be used with Linux really, it seems like
> it's something that normally gets used from userspace by
> libusb but in theory we could have a kernel driver for this
> and plug in whatever SoC I2C/SPI device into a desktop.
> 
> Whatever use it would be ... but could be useful for
> developing drivers for a chip outside of the target
> system I believe.

I would argue that the AB8500 is close enough to a
'system-on-a-chip' to make it depend on CONFIG_SOC, even
though it is technically one half of a 'system-on-two-chips'.

I would also allow x86 and all other architectures to enable
CONFIG_SOC, since there are lots of SoCs these days that combine
an x86 core with the same kind of peripherals we have on ARM
systems. It's just not what you you find in a regualar PC or
Laptop, and anyone building their own kernel can ignore those.

	Arnd
