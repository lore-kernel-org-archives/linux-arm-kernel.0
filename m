From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 7 May 2017 14:38:47 +0200
Subject: [PATCH v2 3/3] gpiolib: Add GPIO initialization
In-Reply-To: <20170507102201.GL22219@n2100.armlinux.org.uk>
References: <1440920686-6892-1-git-send-email-mpa@pengutronix.de>
 <1440920686-6892-4-git-send-email-mpa@pengutronix.de>
 <20170207110950.zy5pzo2hq6hrvmr5@pengutronix.de>
 <20170507102201.GL22219@n2100.armlinux.org.uk>
Message-ID: <20170507123847.dwkr627r6lw5jv3y@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Sun, May 07, 2017 at 11:22:01AM +0100, Russell King - ARM Linux wrote:
> On Tue, Feb 07, 2017 at 12:09:50PM +0100, Uwe Kleine-K?nig wrote:
> > Now additionally I want to initialize some gpios but allow them to be
> > grabbed later. IMHO there are the following new cases:
> > 
> > It should be possible to:
> > 
> >  a) change the value of a gpio initially configured as output
> >  b) change the direction of a gpio initially configured as output
> >  c) change the direction of a gpio initially configured as input
> > 
> > IMHO the dts should describe which case should be applied to a given
> > gpio.
> 
> Isn't it the job of the board firmware to ensure that the hardware is
> setup to a reasonably sane state for the board?
> 
> You give an example of holding GPIOs low in Linux for "ESD reasons"
> later in this thread, but if you're only doing that in Linux, what if
> Linux isn't running yet, and the GPIO has been left floating by the
> board firmware?  Fixing this in Linux is really too late.
> 
> Floating GPIOs are also a source of higher current drain - a GPIO
> sitting mid-rail turns both transistors on for a MOS input, which gives
> a direct path across the power supply.  The quicker that the GPIOs can
> be initialised, the less wasted power there is.  So, that's another
> argument for board firmware doing the basic GPIO initialisation and not
> stuffing this into DT and having the kernel do it.
> 
> We could then talk about floating GPIOs that activate higher power
> devices, and the arguments for doing GPIO initialisation as early as
> possible in board firmware continue to stack up.
> 
> IMHO, initial configuration of GPIOs is the job of board firmware, not
> the kernel.  I see no sane reason to push that into the kernel.

still it is hardware description, isn't it? And Linux isn't the only
consumer of the dtb, barebox understands it, too, and should be teached
to handle the gpio-init stuff once we agreed on a binding.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
