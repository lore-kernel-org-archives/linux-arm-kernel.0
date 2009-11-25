From: kevin.wells@nxp.com (Kevin Wells)
Date: Wed, 25 Nov 2009 22:19:26 +0100
Subject: [PATCH 07/10] ARM: PNX4008: move i2c suspend/resume callbacks
	into driver
In-Reply-To: <20091121185947.GD13956@n2100.arm.linux.org.uk>
References: <20091120144422.GA18223@n2100.arm.linux.org.uk>
	<E1NBUkU-0004Pm-Nv@rmk-PC.arm.linux.org.uk>
	<63386a3d0911210927u47c7d6d6i65fc7d60563f8db2@mail.gmail.com>
	<20091121185947.GD13956@n2100.arm.linux.org.uk>
Message-ID: <083DF309106F364B939360100EC290F804F55C9221@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: Re: [PATCH 07/10] ARM: PNX4008: move i2c suspend/resume callbacks
> into driver
> 
> On Sat, Nov 21, 2009 at 06:27:54PM +0100, Linus Walleij wrote:
> > If you have this up for testing anyway, would it be advisable to take
> this
> > opportunity to also switch i2c-pnx over to using struct dev_pm_ops?
> 

With the clock change below, suspend and resume won't be needed anymore.

> These patches are only compile-tested, and that's partly why there's soo
> many of them - each one does one transformation, which makes it easy to
> review for correctness.
> 
> I'm also hoping that Kevin will test them on later PNX hardware so that
> they can be submitted.

All the I2C patches work fine. In regards to the clock being enabled on
suspend, I think that's a bug - it should be disabled. It only uses extra
power keeping the clock gated on when an I2C transaction isn't in progress.
The clock can be gated on prior to an I2C transaction starting and
then gated off at the end of it. This will save a small trickle of power.

I'll send over patch with these changes.

Kevin
