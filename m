From: andy@warmcat.com (Andy Green)
Date: Wed, 16 Dec 2009 09:40:12 +0000
Subject: [POWER] battery calibration parameters from sysfs
In-Reply-To: <1260919938.10441.18.camel@utx.utx.cz>
References: <A6D19A13FE030A409EC4362C172E091F0E0495F6@eseldmw101.eemea.ericsson.se>	<A6D19A13FE030A409EC4362C172E091F0E071EB9@eseldmw101.eemea.ericsson.se>	<20091207114825.GA26965@rakim.wolfsonmicro.main>	<A6D19A13FE030A409EC4362C172E091F0E0A1FA1@eseldmw101.eemea.ericsson.se>	<20091207165628.GA24981@rakim.wolfsonmicro.main>	<20091213132413.GB1437@ucw.cz>	<20091214121247.GB22388@rakim.wolfsonmicro.main>	<20091214212257.GA9213@elf.ucw.cz>	<ed62800912141543v2ab7ef63v4b6b2c33018b3296@mail.gmail.com>	<4B26FC52.6060307@billgatliff.com>	<ed62800912151458p6bc1e551g54960af40c54facd@mail.gmail.com>
	<1260919938.10441.18.camel@utx.utx.cz>
Message-ID: <4B28AAFC.5010108@warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/15/09 23:32, Somebody in the thread at some point said:

Hi -

>> Yes, but in that case you might as well just purchase a coulomb
>> counter with a built-in accumulator and an I2C/SPI/microwire interface
>> save yourself some PCB space and cost (maybe)
>
> Well, Pavel attempts to implement a "poor man's Coulomb counter" or at
> least "poor man's Ampere meter" for devices that are not equipped with
> any of it.

I think the "poor man's Coulomb counter" is a loser, the errors will 
overwhelm you too rapidly.  The estimated rate of discharge could work, 
based on what clocks, regulators and so on are running, but I am not 
sure how useful that number is really given you can't realistically 
integrate it due to the big error it is bound to have.

I didn't see it mentioned yet but the biggest problem I saw with battery 
state monitoring by voltage alone is what happens during charging: the 
charger is artificially raising the voltage by an amount depending on 
current limit in the charger and battery capacity level.  That's what 
you see when you go and look at battery voltage during charging.

Otherwise for L-ion batteries, looking at the voltage level alone, 
filtered to remove GSM transmit slots etc, is really quite workable for 
estimating charge status.

-Andy
