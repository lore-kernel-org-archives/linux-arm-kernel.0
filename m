From: will.deacon@arm.com (Will Deacon)
Date: Fri, 19 Aug 2011 13:35:43 +0100
Subject: [PATCH] arm/imx: use Kconfig choice for low-level debug UART
	selection
In-Reply-To: <20110819113937.GS31404@pengutronix.de>
References: <1313530873-24961-1-git-send-email-will.deacon@arm.com>
	<1313729819-30301-1-git-send-email-shawn.guo@linaro.org>
	<20110819063533.GR31404@pengutronix.de>
	<20110819110940.GC8918@e102144-lin.cambridge.arm.com>
	<20110819113937.GS31404@pengutronix.de>
Message-ID: <20110819123543.GE8918@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 19, 2011 at 12:39:37PM +0100, Sascha Hauer wrote:
> On Fri, Aug 19, 2011 at 12:09:41PM +0100, Will Deacon wrote:
> > But it's an unfortunate hinderence to a single zImage kernel which we can
> > only solve sensibly in the generic ARM code.
> 
> My problem is that if this option is enabled the kernel will not run
> on any other SoC except the one being selected here, at least when
> earlyprintk is passed on the command line. One could argue
> that this option is for people who exactly know what they do only.
> Still there should pop up a big fat warning somewhere.

Could do - but where?

> The old i.MX way ensured that by refusing to compile the kernel with
> multi SoC support.

That's a worse solution, because now the kernel doesn't run *anywhere* if
you enable DEBUG_LL and multiple SoCs. A use case for the new method is that
you have a kernel .config file for a multi-SoC kernel which is known not to
fail early on a given board. You can enable DEBUG_LL for that board and solve
the problem. It should never be enabled for a kernel that is designed to be
portable!

> > 
> > > At least this should be a choice in Kconfig to make clear that the
> > > different low-level debug options are exclusive.
> > 
> > As Shawn pointed out, we are using a Kconfig choice so you can only select
> > one UART for low-level debug output.
> 
> Ah, ok. I didn't see that Shawns mail was a reply to your series turning
> this into a choice.

Yup - the idea is to force a single UART definition when DEBUG_LL is
enabled.

Will
