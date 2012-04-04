From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 4 Apr 2012 15:23:50 +0000
Subject: [PATCH v2 1/3] PATA host controller driver for ep93xx
In-Reply-To: <4F7C65CE.6000309@metasoft.pl>
References: <4F7B0C54.8010804@metasoft.pl> <4F7C64B8.5000909@metasoft.pl>
 <4F7C65CE.6000309@metasoft.pl>
Message-ID: <201204041523.50872.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 April 2012, Rafal Prylowski wrote:
> > 
> > According to ATA specification, maximum IORDY pulse width is 1250ns,
> > so I'll set timeout to 2ms (I should check this before posting the driver..).
> 
> 2ms is far too big value... Should be 2us.

Ok, in this case, don't use jiffies. I guess it was already flawed because
jiffies doesn't get updated while you are in an interrupt handler.

You could use ktime_get to get a high-resolution time stamp to compare to,
but it depends on how accurate your clocksource is.

	Arnd
