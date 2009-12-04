From: daniel@caiaq.de (Daniel Mack)
Date: Fri, 4 Dec 2009 18:46:23 +0100
Subject: [PATCH] mx31moboard: fix typo
In-Reply-To: <4B19473D.7010801@epfl.ch>
References: <20091203193034.GD22533@pengutronix.de>
	<20091203193321.GE22533@pengutronix.de>
	<Pine.LNX.4.64.0912041013380.3981@axis700.grange>
	<4B19473D.7010801@epfl.ch>
Message-ID: <20091204174623.GW14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 04, 2009 at 06:30:37PM +0100, Valentin Longchamp wrote:
> Guennadi Liakhovetski wrote:
> >...to second that, yesterday's next also locks up hard on boot on
> >pcm037. .config available on request.
> >
> 
> Same problem here. As a matter of fact, it comes from the mxc-master
> branch. I have bisected out the culprit:
> 
> http://git.pengutronix.de/?p=imx/linux-2.6.git;a=commit;h=52939c03e53b151848da9e83fd839bddfda29e78
> 
> It seems conform with the lock syndrom: very early at boot right
> after Uncompessing Linux and before any other message.
> 
> The proc stalls on this read:
> srev = __raw_readl(IO_ADDRESS(IIM_BASE_ADDR) + MXC_IIMSREV);
> 
> Maybe Guennadi and I have silicon revisions that do not work well
> with this patch (because I assume it worked well for Daniel).

Grmpf. Yes, it does work right on my LiteKit board, and the reference
manual reads like the register is there for a very long time (as it has
possible values for very old silicon revisions).

Could you double check whether the clock is running? The only thing I can
think of is differences in the bootloaders. I still have the proprietary
'losh' running here, which I have no sources for.

Daniel
