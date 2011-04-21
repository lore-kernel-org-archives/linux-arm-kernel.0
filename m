From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Apr 2011 10:25:34 +0200
Subject: Status of arch/arm in linux-next
In-Reply-To: <BANLkTinxThB+2+fv4qUD5dyguV-5hUva3A@mail.gmail.com>
References: <20110414094447.GA1611@n2100.arm.linux.org.uk>
	<BANLkTi=kGxL9N-RNqxmeqs4zeYo0zzfmhQ@mail.gmail.com>
	<BANLkTinxThB+2+fv4qUD5dyguV-5hUva3A@mail.gmail.com>
Message-ID: <201104211025.34420.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 April 2011, Linus Walleij wrote:
> > The PRCMU is the Power Reset and Control Management Unit,
> > it is a register pages where you send commands to a firmware
> > running on its own CPU on the other side, partly using mailboxes.
> > The firmware handles things like voltage and power domains
> > (modeled as regulators), frequency changes (using CPUfreq),
> > idle states (CPUidle and sleep, idling), as well as resetting
> > particular memory blocks AND an I2C channel to the AB8500
> > chip (driven from drivers/ab8500-core.c indeed) and some
> > GPIO configuration.
> 
> Reading what I just wrote makes me think this beast may belong
> in drivers/mfd.
> 
> Samuel, would you say I can push this driver to MFD?
> 
> Most MFD things are, like I2C chips and stuff but this one sure
> match the title "multifunctional device", just that it's very singleton
> and very close to the SoC core.

One property of MFD devices is that they register a fixed set of
child devices (cells) that are each providing separate functionality
and have their own drivers. If that's not the case with prcmu,
I think it should not be an MFD driver.

	Arnd
