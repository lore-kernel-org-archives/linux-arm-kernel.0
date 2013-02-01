From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 1 Feb 2013 07:14:50 +0100
Subject: [PATCH v2 1/2] ARM: kirkwood: Ensure that
 kirkwood_ge0[01]_init() finds its clock
In-Reply-To: <20130201001932.GA13044@obsidianresearch.com>
References: <20130129194243.GA30831@schnuecks.de> <51082C4E.5050903@gmail.com>
 <20130130000341.GA10600@schnuecks.de> <51086E86.8040705@gmail.com>
 <20130130083044.GA25688@schnuecks.de> <5108F300.7000705@gmail.com>
 <20130130230100.GV7717@titan.lakedaemon.net>
 <20130131224457.GB17976@schnuecks.de>
 <20130201000109.GK7717@titan.lakedaemon.net>
 <20130201001932.GA13044@obsidianresearch.com>
Message-ID: <20130201061450.GS29973@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> My guesses would be the RTC and/or GPIO blocks (the GPIO blinker needs
> a clock), based on table 94.

I've used AT91 parts where you can do GPO with the clock disabled, but
GPI needed a ticking clock. So, yes, GPIO is a good candidate for
ruint clock as well.

Looking through the data sheets, and comparing against the gated
clocks, we have the following without their own clock:

RTC, I2C (a.k.a. TWI), UART, NAND, SPI, Watchdog, eFuse,

     Andrew
