From: ryan@bluewatersys.com (Ryan Mallon)
Date: Fri, 28 May 2010 09:09:01 +1200
Subject: Controlling Driver Load Order
In-Reply-To: <AANLkTilKUfcYsPqr5kXlONJQAFCaE8D8U9ltQybIzCPu@mail.gmail.com>
References: <AANLkTikzDvWakd7JW3DzTHinjS3dAlqzPx6K8V2qMDG7@mail.gmail.com>	<AANLkTinkY8JYh44UOEPflBUDyQ2wat_AKShRjA3HPxrf@mail.gmail.com>	<20100526235246.GA31068@pengutronix.de>	<AANLkTikj8yGSK5Ovud_k8f6jWloojqDJmQ_H6pD_IFgM@mail.gmail.com>	<20100527041358.GA14070@pengutronix.de>
	<AANLkTilKUfcYsPqr5kXlONJQAFCaE8D8U9ltQybIzCPu@mail.gmail.com>
Message-ID: <4BFEDF6D.3090100@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Emanuele wrote:
> Hi Wolfram,
> 
> I am using the i2c-gpio.c driver, not the i2c-at91 driver.  The Atmel
> folks have expressed concerns over their i2c silicon and wrote a gpio
> version.
> 
> Anyway, I better understand the subsys_initcall now and applied that
> to the i2c-gpio and my i2c chip driver.  That worked perfectly for my
> issue.  I'd be happy to return a patch of this.  Would be this the
> sort of thing that would benefit from a config option?  Something
> like:
> 
> #if defined(CONFIG_EARLY_i2C_GPIO)
> subsys_initcall(i2c_gpio_init);
> #else
> module_init(i2c_gpio_init);
> #endif

Looks like this has already been done:
http://www.mail-archive.com/linux-i2c at vger.kernel.org/msg03056.html

There was a discussion a while back to make all of the embedded i2c
busses be subsys_initcall since i2c is often a system bus on embedded
devices. Looks the i2c_gpio driver got missed the first time round.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
