From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 1 Jul 2015 15:09:03 +0200
Subject: n900 in 4.2-rc0: repeating oopses
In-Reply-To: <20150701103421.GV4156@atomide.com>
References: <20150416093234.GA17423@amd> <20150629091146.GA5103@amd>
 <20150630092404.GA19285@amd> <20150630095310.GF27720@pali>
 <20150701065932.GS4156@atomide.com> <20150701072255.GA17577@pali>
 <20150701095954.GD7969@amd> <20150701103421.GV4156@atomide.com>
Message-ID: <20150701130903.GG7969@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2015-07-01 03:34:22, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [150701 03:02]:
> > On Wed 2015-07-01 09:22:55, Pali Roh?r wrote:
> > > On Tuesday 30 June 2015 23:59:33 Tony Lindgren wrote:
> > > > * Pali Roh?r <pali.rohar@gmail.com> [150630 02:55]:
> > > > > 
> > > > > I will try 4.2 at the end of week.
> > > > 
> > > > At least today's 4.1.0-11549-g05a8256 boots just fine on my n900.
> > > > 
> > > > Regards,
> > > > 
> > > > Tony
> > > 
> > > So, Pavel can you re-test? Maybe there can be problem with some driver
> > > which Tony did not compiled into zImage? Just speculation...
> > 
> > I re-tested with today's git, and it seems to boot. Thanks for help...
> 
> OK good to hear.
>  
> > Now. "echo mem > /sys/power/state" is broken, as in "returns
> > immediately in about 50% cases". The messages are
> > 
> > Powerdomain (per_pwrdm) didn't enter target state 1
> > Powerdomain (core_pwerdm) didn't enter target state 1
> > 
> > Any ideas? Thanks,
> 
> Works for me after enabling the idle timeouts with the following
> script and blanking the screen and disconnecting USB:

Um. I'm forcing suspend with "echo mem > /sys/power/state" . (It
worked in 4.1). That should just make it sleep, no autosuspend-related
trickery... (But yes, I guess I should set up the leds and try
autosuspend, too.)

Regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
