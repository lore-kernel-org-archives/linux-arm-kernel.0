From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Dec 2009 23:06:55 +0000
Subject: [PATCH 07/10] ARM: PNX4008: move i2c suspend/resume callbacks
	into driver
In-Reply-To: <083DF309106F364B939360100EC290F804F55C9221@eu1rdcrdc1wx030.exi.nxp.com>
References: <20091120144422.GA18223@n2100.arm.linux.org.uk>
	<E1NBUkU-0004Pm-Nv@rmk-PC.arm.linux.org.uk>
	<63386a3d0911210927u47c7d6d6i65fc7d60563f8db2@mail.gmail.com>
	<20091121185947.GD13956@n2100.arm.linux.org.uk>
	<083DF309106F364B939360100EC290F804F55C9221@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <20091214230655.GB16953@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2009 at 10:19:26PM +0100, Kevin Wells wrote:
> > Subject: Re: [PATCH 07/10] ARM: PNX4008: move i2c suspend/resume callbacks
> > into driver
> > 
> > On Sat, Nov 21, 2009 at 06:27:54PM +0100, Linus Walleij wrote:
> > > If you have this up for testing anyway, would it be advisable to take
> > this
> > > opportunity to also switch i2c-pnx over to using struct dev_pm_ops?
> > 
> 
> With the clock change below, suspend and resume won't be needed anymore.
> 
> > These patches are only compile-tested, and that's partly why there's soo
> > many of them - each one does one transformation, which makes it easy to
> > review for correctness.
> > 
> > I'm also hoping that Kevin will test them on later PNX hardware so that
> > they can be submitted.
> 
> All the I2C patches work fine. In regards to the clock being enabled on
> suspend, I think that's a bug - it should be disabled. It only uses extra
> power keeping the clock gated on when an I2C transaction isn't in progress.
> The clock can be gated on prior to an I2C transaction starting and
> then gated off at the end of it. This will save a small trickle of power.
> 
> I'll send over patch with these changes.

I didn't hear any response, so the PNX4008 patches are still hanging
around unmerged, and now have rejects.

I'm not attached to these patches so I'm not going to be putting any
additional effort into them (which means I'm not going to be putting
any effort into fixing those rejects or trying to get them merged)
especially as it means that they're now going to have to be maintained
by someone for three months...
