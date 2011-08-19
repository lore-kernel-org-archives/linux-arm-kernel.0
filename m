From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 19 Aug 2011 13:39:37 +0200
Subject: [PATCH] arm/imx: use Kconfig choice for low-level debug UART
	selection
In-Reply-To: <20110819110940.GC8918@e102144-lin.cambridge.arm.com>
References: <1313530873-24961-1-git-send-email-will.deacon@arm.com>
	<1313729819-30301-1-git-send-email-shawn.guo@linaro.org>
	<20110819063533.GR31404@pengutronix.de>
	<20110819110940.GC8918@e102144-lin.cambridge.arm.com>
Message-ID: <20110819113937.GS31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 19, 2011 at 12:09:41PM +0100, Will Deacon wrote:
> Sascha,
> 
> On Fri, Aug 19, 2011 at 07:35:33AM +0100, Sascha Hauer wrote:
> > On Fri, Aug 19, 2011 at 12:56:59PM +0800, Shawn Guo wrote:
> > > Now that the DEBUG_LL UART can be selected by a Kconfig choice,
> > > simplify the #ifdefery in debug-macro.S and add entries to the
> > > top-level Kconfig.debug instead.
> > 
> > I'm unsure whether I like this. The ifdeffery does not look very good,
> > but the Kconfig snippet is not shorter, also it is in generic arm code
> > and not i.MX specific. The old way also makes sure that we do not
> > compile in incompatible lowlevel debug code.
> 
> But it's an unfortunate hinderence to a single zImage kernel which we can
> only solve sensibly in the generic ARM code.

My problem is that if this option is enabled the kernel will not run
on any other SoC except the one being selected here, at least when
earlyprintk is passed on the command line. One could argue
that this option is for people who exactly know what they do only.
Still there should pop up a big fat warning somewhere.
The old i.MX way ensured that by refusing to compile the kernel with
multi SoC support.

> 
> > At least this should be a choice in Kconfig to make clear that the
> > different low-level debug options are exclusive.
> 
> As Shawn pointed out, we are using a Kconfig choice so you can only select
> one UART for low-level debug output.

Ah, ok. I didn't see that Shawns mail was a reply to your series turning
this into a choice.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
