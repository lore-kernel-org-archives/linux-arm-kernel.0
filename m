From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 8 Sep 2011 16:56:33 +0200
Subject: [PATCH 2/6] arm/imx6q: add core definitions and low-level debug
	uart
In-Reply-To: <alpine.LFD.2.00.1109071128040.20358@xanadu.home>
References: <1315303120-24203-1-git-send-email-shawn.guo@linaro.org>
	<20110907142350.GU6619@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1109071128040.20358@xanadu.home>
Message-ID: <201109081656.33404.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 September 2011, Nicolas Pitre wrote:
> On Wed, 7 Sep 2011, Russell King - ARM Linux wrote:
> 
> > On Wed, Sep 07, 2011 at 02:36:35PM +0200, Uwe Kleine-K?nig wrote:
> > > But only if the image doesn't support imx6q, right? Anyhow, I hope
> > > imx6q_map_io isn't called for pre-imx6q SoCs. Ah, and I hope we don't
> > > need to argue here as Russell doesn't like the new DEBUG_LL changes :-)
> > 
> > I have no problem with the Kconfig menu approach or existing approaches
> > to DEBUG_LL.  What I have an objection to is trying to stuff the
> > information for it into places which ultimately render the facility
> > useless for its intended purpose - to permit debugging the really
> > early assembly code.
> > 
> > That is what it was written for: if we introduce complicated ways to
> > put behind it, we'll need to come up with a completely new debugging
> > infrastructure to debug the now buggered debugging infrastructure.
> 
> For the record I now agree with Russell.
> 
> In order to have early serial output that works across multiple SOCs in 
> the same kernel image intended to non developers we'll have to add a 
> parallel infrastructure.  Keeping the DEBUG_LL code as simple as 
> possible for developers is the way to go (and that might be needed to 
> debug that parallel infrastructure).

Yes, agreed. It should not be too hard to provide more CON_BOOT consoles.
For 8250, this can actually be done already using the code from
drivers/tty/serial/8250_early.c with a custom command line, but there
are better ways to do that in a generic way.

	Arnd
