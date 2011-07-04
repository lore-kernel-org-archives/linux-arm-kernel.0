From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 4 Jul 2011 16:07:10 +0200
Subject: [PATCH 1/3] PWM: add pwm framework support
In-Reply-To: <20110704124318.GI6069@pengutronix.de>
References: <201106301441.24493.arnd@arndb.de> <4E11994B.7070103@gmail.com>
	<20110704124318.GI6069@pengutronix.de>
Message-ID: <201107041607.10265.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 July 2011, Sascha Hauer wrote:
> On Mon, Jul 04, 2011 at 08:43:23PM +1000, Ryan Mallon wrote:
>
> > The fine-grained control api could be added now. pwm_config could be
> > left as is for the time being (the new api could be a wrapper around it
> > to start with). Polarity control and interrupt handling apis could also
> > be defined without affecting the drivers which don't need to implement
> > them. Multiple channels and the sleeping/non-sleeping api are the more
> > difficult ones, but at least having some sort of indication about how
> > these plan to be solved would be useful.
> 
> Again, why should we add these *now*? It only raises the chance that
> there's more discussion.

My impression is that there are a lot of things that could easily be
done to improve the state of PWM drivers, but I don't care about the
order in which they are done. My main issue is the lack of a subsystem
core driver, which both you and Bill have patches for. It's clear that
other people have other issues and want to see their problems addressed
first.

I also think that the pwm code is simple enough that we don't have
to worry too much about the order that things are done in. Any patch
that is making the code better should just get in and not have to
wait for something else to be completed first.

What we do need now is a maintainer that can coordinate the patches
and merge the ones that have been agreed on. Or multiple maintainers.

	Arnd
