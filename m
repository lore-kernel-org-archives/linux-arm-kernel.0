From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 18 Dec 2009 09:48:50 +0100
Subject: [POWER] battery calibration parameters from sysfs
In-Reply-To: <4B28AAFC.5010108@warmcat.com>
References: <A6D19A13FE030A409EC4362C172E091F0E0A1FA1@eseldmw101.eemea.ericsson.se>
	<20091207165628.GA24981@rakim.wolfsonmicro.main>
	<20091213132413.GB1437@ucw.cz>
	<20091214121247.GB22388@rakim.wolfsonmicro.main>
	<20091214212257.GA9213@elf.ucw.cz>
	<ed62800912141543v2ab7ef63v4b6b2c33018b3296@mail.gmail.com>
	<4B26FC52.6060307@billgatliff.com>
	<ed62800912151458p6bc1e551g54960af40c54facd@mail.gmail.com>
	<1260919938.10441.18.camel@utx.utx.cz>
	<4B28AAFC.5010108@warmcat.com>
Message-ID: <20091218084850.GA1513@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!1


>>> Yes, but in that case you might as well just purchase a coulomb
>>> counter with a built-in accumulator and an I2C/SPI/microwire interface
>>> save yourself some PCB space and cost (maybe)

Hardware is already given.

>> Well, Pavel attempts to implement a "poor man's Coulomb counter" or at
>> least "poor man's Ampere meter" for devices that are not equipped with
>> any of it.
>
> I think the "poor man's Coulomb counter" is a loser, the errors will  
> overwhelm you too rapidly.  The estimated rate of discharge could
>> work,  

Actually android phones do "poor man's Coulomb counter", and it seems
to mostly work.

> based on what clocks, regulators and so on are running, but I am not  
> sure how useful that number is really given you can't realistically  
> integrate it due to the big error it is bound to have.
...
> Otherwise for L-ion batteries, looking at the voltage level alone,  
> filtered to remove GSM transmit slots etc, is really quite workable for  
> estimating charge status.

Well, you have to compensate for backlight power; and yes, that's what
I'm trying to do.
								Pavel 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
