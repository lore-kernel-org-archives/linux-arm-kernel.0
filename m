From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 30 Jan 2017 08:56:09 +0100
Subject: [PATCH] MAINTAINERS: extend Raspberry Pi entry
In-Reply-To: <1485728648.30797.9.camel@crowfest.net>
References: <b2e1e59a752395314a20e846337cb70cf22f2959.1485720503.git.baruch@tkos.co.il>
 <1485723150.30797.1.camel@crowfest.net>
 <20170129210611.k46ey35py3ht3fe7@tarshish>
 <1485726109.30797.5.camel@crowfest.net>
 <20170129215253.hwhwsqoulhmjxs55@tarshish>
 <1485727324.30797.7.camel@crowfest.net>
 <1485728648.30797.9.camel@crowfest.net>
Message-ID: <20170130075609.pcrujbzdnabkmuux@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 29, 2017 at 02:24:08PM -0800, Michael Zoran wrote:
> On Sun, 2017-01-29 at 14:02 -0800, Michael Zoran wrote:
> > Perhaps you have some idiot that doesn't know what they are doing.?
> > If you confine their changes to a certain directory, in theory it
> > would limit that amount of damage that could be done(to a certain
> > extent).

That's why you get a shortstat when doing a pull or merge. And given
these responsibilites are not sharp. So sometimes a dt change comes in
the i2c pull. Then the i2c maintainer points that out in the pull
request and the commit has an ack from a dt guy.

I think you cannot simplify this with technical means that stop you when
a tree contains changes not in its area of responsibility.

> > At the very minimum, I would think that hardware specific drivers
> > should be handled differently then core drivers or non-platform
> > specific drivers.

I don't agree. To be able to review a driver to a Broadcom specific spi
driver, you need to know more about spi than about Broadcom.

> > I mean really, why should the vendor of the RPI have to deal with a
> > gazillion requests to change the default built configuration.

I cannot follow. If you want to change the defconfig for the RPI you
modify a file in arch/arm/boot/config and send the change to the ARM
people.

> > But then again, having everything in one tree makes it easy to make
> 
> Basically, what I'm thinking is this:
> 
> Have a bcm283x module that is somehow changed locally and tested
> locally, but the whole module gets published to the larger tree as a

There is nothing stopping you here to provide a tree with all adaptions
needed for your machine. You won't probably get this merged into next
(or another tree) though.

> snapshot.  Anybody that normally submits changes to bcm283x can change
> any file.  I wouldn't take things to the extreme of having an owner of
> the i2c module and another owner of the SPI module. The modules should

It's well possible (and usual) that the "owner" of the spi and the i2c
driver are the same.

> be reasonably large.
> 
> If it's better to have binary drops or source code drops I'm not sure. 
> Source drops with some change history makes more sense to me.
> 
> As for the signed off part or requiring multiple signed off bys, that
> seems broken to me.  The idea of having multiple people approve of
> every single change is awesome.  But at the same time it needs to be
> built into the software revision control system.  I mean, I e-mail a
> patch or change with my name.  I really don't have any idea, control,
> or verification that the change I e-mail is actually the change that is
> getting applied with my name on it.

Yes, you have a mean to verify. For example git patch-id works.

And I wonder what you suggest to make sure that nobody is able to fake
being you and get a patch committed in your name. (Maybe there exists
even another guy with your name?)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
