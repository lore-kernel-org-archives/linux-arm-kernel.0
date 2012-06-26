From: jbe@pengutronix.de (Juergen Beisert)
Date: Tue, 26 Jun 2012 10:12:13 +0200
Subject: i.MX28 die temperature
In-Reply-To: <201206221919.57485.marek.vasut@gmail.com>
References: <330B740BA662BF4E8386F534DF556ED819731A@AEDCEXC09.aei.com>
 <201206221349.18326.jbe@pengutronix.de>
 <201206221919.57485.marek.vasut@gmail.com>
Message-ID: <201206261012.13620.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

Marek Vasut wrote:
> [...]
> > > Take a look at: http://www.spinics.net/lists/linux-iio/msg04345.html
> >
> > Any progress here with inclusion in some git tree?
>
> Well ... I recently raised from the dead. It's on the schedule, obviously
> help is welcome.

I tried a little bit with your driver. The disadvantage I see is, its claims 
all the free AD channels. But a few of them can also act as a touchscreen 
controller. Shouldn't be the driver handle the channel usage dynamically? 
Also this AD module on the SoC can measure the die temperature, battery 
voltage and some other power supplies.
I see more than one framework this driver should connect to: simple ADC (IIO), 
touchscreen controller (INPUT), die temp (POWER?), various voltages (POWER? 
REGULATOR?). Should it be a multi function device?

Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | http://www.pengutronix.de/  |
