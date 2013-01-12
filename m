From: nico@fluxnic.net (Nicolas Pitre)
Date: Sat, 12 Jan 2013 12:19:54 -0500 (EST)
Subject: [PATCH] ARM: let CPUs not being able to run in ARM mode enter in
 THUMB mode
In-Reply-To: <20130111155150.GL14860@pengutronix.de>
References: <1357904397-8476-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <50F0310F.3070502@arm.com> <20130111155150.GL14860@pengutronix.de>
Message-ID: <alpine.LFD.2.02.1301121219140.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Jan 2013, Uwe Kleine-K?nig wrote:

> Hi Jonny,
> 
> On Fri, Jan 11, 2013 at 03:34:39PM +0000, Jonathan Austin wrote:
> > Hi Uwe,
> > On 11/01/13 11:39, Uwe Kleine-K?nig wrote:
> > >Some ARM cores are not capable to run in ARM mode (e.g. Cortex-M3). So
> > >obviously these cannot enter the kernel in ARM mode. Make an exception
> > >for them and let them enter in THUMB mode.
> > 
> > Clearly something like this is necessary, but it isn't something I'd
> > like for people to start using *unless* they have a THUMB only CPU
> > (for example, to work around dodgy boot-loaders, etc)
> > 
> > Seeing as there are no THUMB-only CPUs with an MMU, I think we could
> > safely constrain this change to:
> > a) depend on !MMU
> > b) only touch head-nommu.S
> > 
> > Does that cause any issue for what you're doing.
> Would be ok for me, too. I don't care much.

Please do so then.  I had the same concern.


Nicolas
