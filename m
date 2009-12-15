From: utx@penguin.cz (Stanislav Brabec)
Date: Wed, 16 Dec 2009 00:32:18 +0100
Subject: [POWER] battery calibration parameters from sysfs
In-Reply-To: <ed62800912151458p6bc1e551g54960af40c54facd@mail.gmail.com>
References: <A6D19A13FE030A409EC4362C172E091F0E0495F6@eseldmw101.eemea.ericsson.se>
	<A6D19A13FE030A409EC4362C172E091F0E071EB9@eseldmw101.eemea.ericsson.se>
	<20091207114825.GA26965@rakim.wolfsonmicro.main>
	<A6D19A13FE030A409EC4362C172E091F0E0A1FA1@eseldmw101.eemea.ericsson.se>
	<20091207165628.GA24981@rakim.wolfsonmicro.main>
	<20091213132413.GB1437@ucw.cz>
	<20091214121247.GB22388@rakim.wolfsonmicro.main>
	<20091214212257.GA9213@elf.ucw.cz>
	<ed62800912141543v2ab7ef63v4b6b2c33018b3296@mail.gmail.com>
	<4B26FC52.6060307@billgatliff.com>
	<ed62800912151458p6bc1e551g54960af40c54facd@mail.gmail.com>
Message-ID: <1260919938.10441.18.camel@utx.utx.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Aras Vaichas wrote:

> Yes, but in that case you might as well just purchase a coulomb
> counter with a built-in accumulator and an I2C/SPI/microwire interface
> save yourself some PCB space and cost (maybe)

Well, Pavel attempts to implement a "poor man's Coulomb counter" or at
least "poor man's Ampere meter" for devices that are not equipped with
any of it.

- We know the time.
- We know the backlight power consumption, it's dependent only on
  brightness.
- We know how much eats the HDD and how long it is on.
- We know how much eats the CPU and companion chips (it is not as
  stable, but it eats less).
- We don't know, how much USB host eats, but we know how much USB
  clients claim to eat.
- Well, and we don't know how much eats CF and SD.

=> We can guess how many Coulombs the device already consumed. If the
Coulomb counting would be inaccurate, we can at least correct voltage ->
remaining energy table using current power consumption guess.


________________________________________________________________________
Stanislav Brabec
http://www.penguin.cz/~utx/zaurus
