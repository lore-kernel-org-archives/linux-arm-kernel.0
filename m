From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 8 Dec 2011 23:31:44 +0100
Subject: [PATCH] Documentation/pinctrl: various minor fixes
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF1750B77B9F@HQMAIL01.nvidia.com>
References: <1323382892-28298-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <74CDBE0F657A3D45AFBB94109FB122FF1750B77B9F@HQMAIL01.nvidia.com>
Message-ID: <20111208223144.GQ4585@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 08, 2011 at 02:24:46PM -0800, Stephen Warren wrote:
> Uwe Kleine-K?nig wrote at Thursday, December 08, 2011 3:22 PM:
> > - add some consts
> > - don't use the group index alone to determine the value to write to
> >   foo's mux register. For spi and i2c the group index is always 0.
> >   Additionally using the function index makes much more sense as it
> >   generates a different value for each function/group pair.
> > - fix a few syntax errors
> 
> > @@ -600,7 +600,7 @@ static int foo_get_groups(struct pinctrl_dev *pctldev, unsigned selector,
> >  int foo_enable(struct pinctrl_dev *pctldev, unsigned selector,
> >  		unsigned group)
> >  {
> > -	u8 regbit = (1 << group);
> > +	u8 regbit = (1 << selector + group);
> > 
> >  	writeb((readb(MUX)|regbit), MUX)
> >  	return 0;
> > @@ -609,7 +609,7 @@ int foo_enable(struct pinctrl_dev *pctldev, unsigned selector,
> >  int foo_disable(struct pinctrl_dev *pctldev, unsigned selector,
> >  		unsigned group)
> >  {
> > -	u8 regbit = (1 << group);
> > +	u8 regbit = (1 << selector);
> > 
> >  	writeb((readb(MUX) & ~(regbit)), MUX)
> >  	return 0;
> 
> Shouldn't those two regbit calculations match?
Yes, of course. (Well, it depends on the register model ...)

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
