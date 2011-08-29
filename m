From: rpurdie@rpsys.net (Richard Purdie)
Date: Mon, 29 Aug 2011 22:34:58 +0100
Subject: [PATCH] leds: kill CONFIG_LEDS_CLASS option
In-Reply-To: <alpine.LFD.2.00.1108291630020.20358@xanadu.home>
References: <1314647628-21707-1-git-send-email-bryan.wu@canonical.com>
	<alpine.LFD.2.00.1108291630020.20358@xanadu.home>
Message-ID: <1314653699.5939.299.camel@rex>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-08-29 at 16:34 -0400, Nicolas Pitre wrote:
> On Tue, 30 Aug 2011, Bryan Wu wrote:
> 
> > Almost all the new leds driver and trigger driver are depends on
> > CONFIG_LED_CLASS, so there is no such user with CONFIG_NEW_LEDS=y
> > and CONFIG_LED_CLASS=n. Moreover, lots of API functions in led-class.c
> > are very common and should be built-in when CONFIG_NEW_LEDS=y.
> > 
> > Obviously, CONFIG_LEDS_CLASS is pointless. This patch kills it and
> > also updates defconfigs which contains CONFIG_LEDS_CLASS.
> > 
> > Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
> > ---

Looking at the code I'm a little concerned to see the direction this is
going. There was originally a reason that there were two options, it was
related to being able to compile as much of the LED code as a module as
possible.

It looks like commit 5ada28bf76752e33dce3d807bf0dfbe6d1b943ad changed
the tristate to a bool at which point the separate option obviously
becomes pointless.

Rather than accept the current direction and force everything builtin,
I'd much rather this code became modular capable again. There is no good
reason we should be forced to build everything into a kernel.

Cheers,

Richard
