From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Nov 2011 20:24:25 +0000
Subject: [PATCH] arm/imx: use Kconfig choice for low-level debug UART
 selection
In-Reply-To: <20111122164707.GJ6624@sirena.org.uk>
References: <1313530873-24961-1-git-send-email-will.deacon@arm.com>
 <1313729819-30301-1-git-send-email-shawn.guo@linaro.org>
 <20111122085834.GB19986@pengutronix.de>
 <20111122115017.GK20518@mudshark.cambridge.arm.com>
 <20111122130233.GF19986@pengutronix.de>
 <20111122132055.GA32572@mudshark.cambridge.arm.com>
 <20111122133040.GG19986@pengutronix.de>
 <20111122154838.GZ9581@n2100.arm.linux.org.uk>
 <20111122163812.GH19986@pengutronix.de> <20111122164707.GJ6624@sirena.org.uk>
Message-ID: <20111122202425.GD9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 04:47:07PM +0000, Mark Brown wrote:
> On Tue, Nov 22, 2011 at 05:38:12PM +0100, Uwe Kleine-K?nig wrote:
> > On Tue, Nov 22, 2011 at 03:48:38PM +0000, Russell King - ARM Linux wrote:
> 
> > > > Ah, I see the problem. It's more subtile than just failure to build: it
> > > > autoselects DEBUG_ICEDCC then.
> 
> > > At this point, I think the right answer is to remove the option in
> > > linux-next, and tell anyone who complains that they need to convert
> > > their platform properly.  (We're going to need them converted in this
> > > way anyway for the single zImage project.)
> 
> > I agree.
> 
> It'd be nice if things could be arranged so that the build breaks rather
> than selecting ICEDCC on unconverted platforms - when you run into the
> problem it's not that easy to diagnose.

Well, we could leave the choice as is, and make the NONE option cause a
#error.
