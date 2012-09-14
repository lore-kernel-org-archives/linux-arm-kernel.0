From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Sep 2012 20:01:33 +0000
Subject: [PATCH V4 1/5] ARM: add infra-structure for BCM2835 and Raspberry
 Pi
In-Reply-To: <50535283.9040905@wwwdotorg.org>
References: <1347597684-30805-1-git-send-email-swarren@wwwdotorg.org>
 <201209140750.44039.arnd@arndb.de> <50535283.9040905@wwwdotorg.org>
Message-ID: <201209142001.33954.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 September 2012, Stephen Warren wrote:
> I guess I can see the advantage of having the .dts reg values match the
> documentation. I just worry that doing so is more about matching the
> documentation rather than describing the true HW. Still, I suppose with
> the ranges property, it's clear what the true physical addresses are..
> It also introduces a completely fake bus just to perform the address
> re-writing; I wonder if putting the ranges property at the top-level
> node work instead?.

I don't think it easily works with the reg property in the root.
Having a node for the "soc" components isn't all that unusual,
a bunch of other platforms do that.

The advantage is that we have something to conceptually group
all the on-chip components, and it works with the infrastructure
in drivers/base/soc.c.

> So  now that almost everything is ack'd, how should this get into the
> tree - will you take (an updated version of) these patches and apply
> them directly to arm-soc, or should I commit them and send a pull
> request? (For the latter, I'd have to look up how to create a new k.org
> git repo).

We can do whatever suits you best. Pull requests are slightly faster
to import. It's also ok if you use the linux-tegra git this time fi that
helps you.

	Arnd
