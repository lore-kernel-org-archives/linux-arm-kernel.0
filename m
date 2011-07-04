From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 4 Jul 2011 15:53:07 +0200
Subject: [PATCH 1/3] PWM: add pwm framework support
In-Reply-To: <20110704110523.GB316@e-circ.dyndns.org>
References: <201106301441.24493.arnd@arndb.de> <4E11994B.7070103@gmail.com>
	<20110704110523.GB316@e-circ.dyndns.org>
Message-ID: <201107041553.07643.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 July 2011, Kurt Van Dijck wrote:
> > 
> > The pwm framework needs to incorporate at least the following:
> >  - sysfs access (ep93xx driver)
> >  - Multiple channels per device (atmel driver)
> 
> These are 2 very hardware dependant additions. Is this really the job
> for a framework to incorporate this?
> IMHO, the job of a framework is to allow such things. Creating a framework
> that does all special things of all vendors makes such thing
> complicated.

I think you shouldn't make it too easy for drivers to add extra
sysfs files. If at all possible, the default should be to add
them to the core, and define them in a way that makes sense for
future similar drivers.

We need to be careful to avoid a situation where multiple driver
writers introduce the same feature with a sysfs attribute, but do
so in an incompatible way.

> With socketCAN, we encountered a similar problem. Every chip maker
> tries to create added value by means of special options. You can't
> support them all in the framework. Therefore, sysfs can be added
> to configure special things.

I would expect that pwm is much simpler than CAN, so the amount
of creativity there is also limited.

	Arnd
