From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 23 Nov 2016 15:59:16 +0100
Subject: [PATCH RFC] ARM: dts: add support for Turris Omnia
In-Reply-To: <1479851991.26813.2@smtp.gmail.com>
References: <20161105203841.9661-1-uwe@kleine-koenig.org>
 <1479126185.15557.5@smtp.gmail.com>
 <20161114201640.rr32iyjf5a53v33t@perseus.defre.kleine-koenig.org>
 <20161114202832.GG24546@lunn.ch>
 <1479586147.10840.0@smtp.gmail.com>
 <20161120203037.pd5mhqyjeotileve@perseus.defre.kleine-koenig.org>
 <1479851991.26813.2@smtp.gmail.com>
Message-ID: <20161123145916.GL14947@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >CZ11NIC12 is indicated on my board.
> 
> :-( Well, this board version has wrongly matched length of some
> differential pairs, IRQ from 88E1514 is connected differently, there
> are slight differences in power supplies and (if I am not mistaken)
> something changed in RTC support circuitry. It looks like a huge
> mistake on our side.

Hi Tomas

Would these problems also explain why the Ethernet links to the switch
don't work? Maybe the differential pairs?

> It seems that libphy is probed before pca9538 and we end up with:
> [    4.217550] libphy: orion_mdio_bus: probed
> [    4.221777] irq: no irq domain found for
> /soc/internal-regs/i2c at 11000/i2cmux at 70/i2c at 7/gpio at 71 !
> 
> Any clue where to look in order to defer probing libphy or at least
> orion_mdio_bus?

I think there is a known phylib problem here. Somewhere in the call
chain there is a void function, so the EPROBE_DEFFER gets
discarded. But i could be remembering this wrongly.

      Andrew
