From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 2 Jul 2015 22:25:28 +0200
Subject: n900 in 4.2-rc0: repeating oopses
In-Reply-To: <20150701103421.GV4156@atomide.com>
References: <20150416093234.GA17423@amd> <20150629091146.GA5103@amd>
 <20150630092404.GA19285@amd> <20150630095310.GF27720@pali>
 <20150701065932.GS4156@atomide.com> <20150701072255.GA17577@pali>
 <20150701095954.GD7969@amd> <20150701103421.GV4156@atomide.com>
Message-ID: <20150702202528.GA3387@amd>
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

Hmm. Tried to toggle brightness on 4.1, and after few changes:

root at n900:~# echo 255 > /sys/class/backlight/acx565akm/brightness
root at n900:~# echo 120 > /sys/class/backlight/acx565akm/brightness
root at n900:~# echo 10 > /sys/class/backlight/acx565akm/brightness
root at n900:~# echo 1 > /sys/class/backlight/acx565akm/brightness



^C^C
^Z

seems like acx565akm hung :-(.
									Pavel
									
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
