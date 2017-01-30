From: mzoran@crowfest.net (Michael Zoran)
Date: Mon, 30 Jan 2017 01:01:16 -0800
Subject: [PATCH] MAINTAINERS: extend Raspberry Pi entry
In-Reply-To: <20170130085128.wewxe6rw42hoqdpu@pengutronix.de>
References: <b2e1e59a752395314a20e846337cb70cf22f2959.1485720503.git.baruch@tkos.co.il>
 <1485723150.30797.1.camel@crowfest.net>
 <20170129210611.k46ey35py3ht3fe7@tarshish>
 <1485726109.30797.5.camel@crowfest.net>
 <20170129215253.hwhwsqoulhmjxs55@tarshish>
 <1485727324.30797.7.camel@crowfest.net>
 <1485728648.30797.9.camel@crowfest.net>
 <20170130075609.pcrujbzdnabkmuux@pengutronix.de>
 <1485763772.13537.1.camel@crowfest.net>
 <20170130085128.wewxe6rw42hoqdpu@pengutronix.de>
Message-ID: <1485766876.13537.3.camel@crowfest.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-01-30 at 09:51 +0100, Uwe Kleine-K?nig wrote:
> On Mon, Jan 30, 2017 at 12:09:32AM -0800, Michael Zoran wrote:
> > On Mon, 2017-01-30 at 08:56 +0100, Uwe Kleine-K?nig wrote:
> > > On Sun, Jan 29, 2017 at 02:24:08PM -0800, Michael Zoran wrote:
> > > I don't agree. To be able to review a driver to a Broadcom
> > > specific
> > > spi
> > > driver, you need to know more about spi than about Broadcom.
> > > 
> > 
> > I would say that's 50/50.??Some of these drivers like I2C or SPI
> > are?not really that complex.??The complexity happens when people
> > begin
> > to try to connect the various drivers in arbitrary ways at which
> > point
> > things begin to break.
> > 
> > SOCs are designed with cost in mind, so allowing arbitrary
> > configurations are not aways possible because of attempts to limits
> > the
> > amount of hardware resources required and the complexity. And I
> > don't
> > think this is specific to Broadcom or anybody. It's just the way
> > SOCs
> > work.
> > 
> > This is all vary different from PCs where you expect people to buy
> > random parts and start connecting them together.??For the reasons I
> > have given, SOCs arn't quite as flexible.
> 
> I fail to follow here. Can you please show an example where you see a
> benefit from having the drivers grouped by SoC instead of bus type?
> 

Two that instantly come to mind are GPIO function assignment and clock
management.   Most SOCs and I'm not just talking about the RPI can't
handle arbitrary configuration of GPIO function mapping.  They also
tend to generate one clock off the other for different peripherals. 
Change the clock of one peripheral or the CPU, and other peripheral
breaks.
