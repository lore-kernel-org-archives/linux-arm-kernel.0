From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 23 Sep 2010 13:07:33 +0200
Subject: [PATCH] at91sam9g45: fix i2c bus speed
In-Reply-To: <20100923103645.GA23295@n2100.arm.linux.org.uk>
References: <1285147886-17100-1-git-send-email-jacmet@sunsite.dk>
	<4C9B0D4D.4050102@atmel.com> <87k4mcak6b.fsf@macbook.be.48ers.dk>
	<20100923093104.GA22397@n2100.arm.linux.org.uk>
	<87fwx0ahgl.fsf@macbook.be.48ers.dk>
	<20100923103645.GA23295@n2100.arm.linux.org.uk>
Message-ID: <20100923110733.GY32018@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11:36 Thu 23 Sep     , Russell King - ARM Linux wrote:
> On Thu, Sep 23, 2010 at 12:21:14PM +0200, Peter Korsgaard wrote:
> > >>>>> "Russell" == Russell King <- ARM Linux <linux@arm.linux.org.uk>> writes:
> > 
> >  Russell> udelay(5) should always give something approximating a 5us
> >  Russell> delay, as we calibrate this delay loop against the system
> >  Russell> timer.  What I could believe is probably going on here is that
> >  Russell> writing to the hardware is adding additional delays - but
> >  Russell> that's nothing to do with the CPU speed itself.
> > 
> > Well, the gpio handling (sw) overhead is to a certain degree related to
> > the CPU speed.
> 
> Isn't that what I said?
> 
> Jean is right - if you want to care this much about getting the I2C
> transfer rate as close to 100kHz or 400kHz (without exceeding it),
> you need to pass the required speed and run some sort of calibration
> in the driver to calculate the correct delay.
> 
> Howver, the danger of using 3us instead of 5us is that you may measure
> 3us using the bus conditions at the time of measurement - which may be
> contributing to the delay.  What happens if these bus conditions change?
> For example, if you move to a different operating point and the bus speed
> increases ?
> 
> Note that the calibration approach will also suffer from this problem.
I was thinking of a pseudo clock maybe that we will make evolving depending of
the bus clock typically PM
but I'm still afraid that will also depend on the cpu load but it we take a
max boundry when the cpu load is low at least we will not increase the bus max
speed

Best Regards,
J.
