From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 10 Sep 2015 09:53:41 +0200
Subject: [PATCH v2 1/3] ARM: Make FORCE_MAX_ZONEORDER configurable if
 ARM_SINGLE_ARMV7M
In-Reply-To: <20150909054125.GA14598@pengutronix.de>
References: <1441744686-20521-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1441744686-20521-2-git-send-email-mcoquelin.stm32@gmail.com>
 <20150908221912.GE21084@n2100.arm.linux.org.uk>
 <20150909054125.GA14598@pengutronix.de>
Message-ID: <20150910075340.GJ14598@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 09, 2015 at 07:41:25AM +0200, Uwe Kleine-K?nig wrote:
> On Tue, Sep 08, 2015 at 11:19:13PM +0100, Russell King - ARM Linux wrote:
> > On Tue, Sep 08, 2015 at 10:38:04PM +0200, Maxime Coquelin wrote:
> > > This patch makes FORCE_MAX_ZONEORDER configurable in defconfig for ARMV7-M
> > > when built for a single platform.
> > 
> > I'd prefer if we didn't do this, because this isn't supposed to be a user
> > visible "option".  It's an option that was introduced to avoid having to
> > throw masses of #ifdefs into the definition of MAX_ZONEORDER.
> > 
> > The problem with it is that it's a "well, what do I set this to?" option
> > and that leads to "oh, I'll just choose the default because I don't know
> > any better".
> > 
> > Do we know why EFM32 needs a value of 9 here?  It's not documented in
> > the original commit, and it really _should_ have been.
> IIRC it was done because of memory pressure. But not sure this makes any
> sense. I will try with the default value later today and report back.
I updated my patch stack to 4.2 and the difference between 9 and 11 is:

Using 9:

	/ # free
		     total         used         free       shared      buffers
	Mem:          3744         1688         2056            0            0
	-/+ buffers:               1688         2056

vs. using 11:

	/ # free
		     total         used         free       shared      buffers
	Mem:          3744         1696         2048            0            0
	-/+ buffers:               1696         2048

so it works with bearable costs. If you want to get rid of the special
casing for efm32 that's fine for me.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
