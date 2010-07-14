From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 15 Jul 2010 00:51:50 +0200
Subject: [PATCH v2 2/2] ux500: add ab8500-regulators machine specific data
In-Reply-To: <20100714184251.GG5933@sirena.org.uk>
References: <20100713203852.GA1756@rakim.wolfsonmicro.main>
	<20100714145053.GA1689@bnru01.bnr.st.com>
	<20100714145748.GF31073@rakim.wolfsonmicro.main>
	<20100714153643.GB1689@bnru01.bnr.st.com>
	<20100714154726.GH31073@rakim.wolfsonmicro.main>
	<20100714160941.GC1689@bnru01.bnr.st.com>
	<20100714162048.GA27512@rakim.wolfsonmicro.main>
	<20100714164708.GD1689@bnru01.bnr.st.com>
	<20100714170323.GF5933@sirena.org.uk>
	<20100714173650.GA21893@bnru01.bnr.st.com>
	<20100714184251.GG5933@sirena.org.uk>
Message-ID: <AANLkTimWjozzhTG491JVLUIICh6YonO4Emp07AG1nMj-@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/14 Mark Brown <broonie@opensource.wolfsonmicro.com>:

>> > This is normal, but for fairly obvious reasons the very lowest power
>> > states are generally handled outside of the regulator API at a hardware
>> > level via hardware signals to the regulator. ?It's not normally part of
>> > the runtime constraints for use while the CPU is live.
>
>> Yes. But my point was that even at a lower level than kernel (BIOS/firmware?)
>> the switching would happen via SW. Please correct me if I am wrong!
>
> Well, ultimately it's always triggered by software but the actual signal
> to the regulator is often a logic level output by the SoC as the
> processor enters a low power state rather than an I2C/SPI write.

I can answer this: on the U300 we had such autonomous signals that
would augment the power state of the regulators by special sleep
signals.

For U8500 there is a dedicated autonomous system in the silicon, called
PRCMU (Power Reset Clock Management Unit) that will actually do
this using I2C because it has its own CPU and can transmit I2C
messages even when the ARM CPU cores are turned off. So this is
indeed a first-timer and not strange that it looks unfamiliar ...

Yours,
Linus Walleij
