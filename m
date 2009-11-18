From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 18 Nov 2009 18:28:49 +0100
Subject: [PATCH] hx4700: fix hx4700 touchscreen pressure values
In-Reply-To: <E1NAYJo-00016g-PW@pih-relay04.plus.net>
References: <E1NAYJo-00016g-PW@pih-relay04.plus.net>
Message-ID: <20091118172849.GD25150@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2009-11-18 00:22:41, Paul Parsons wrote:
> > Does pressure actually work as expected -- that is not inverted?
> > Because I need this patch on spitz...  but it may break your
> > machine...
> 
> You are right, the pressure values were being inverted on my hx4700.
> Pressing hard generates somewhat lower Rt values than pressing lightly.
> 
> Since typical hx4700 Rt values are close to (pressure_max/2) anyway,
> the inverted and non-inverted values were not very different.
> For example:
> 
> Rt      ts->pressure_max-Rt
> 599     425
> 562     462
> 588     436
> 570     454
> 
> So by all means submit your ads7846.c patch; it will not break hx4700.

Dmitry, those pressure values are reverted on more than one machine,
and we do not have anyone reporting it works ok for them. Can we
perhaps just.... fix it?
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
