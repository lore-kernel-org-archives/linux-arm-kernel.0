From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Wed, 18 Nov 2009 09:39:34 -0800
Subject: [PATCH] hx4700: fix hx4700 touchscreen pressure values
In-Reply-To: <20091118172849.GD25150@elf.ucw.cz>
References: <E1NAYJo-00016g-PW@pih-relay04.plus.net>
	<20091118172849.GD25150@elf.ucw.cz>
Message-ID: <20091118173934.GA4458@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2009 at 06:28:49PM +0100, Pavel Machek wrote:
> On Wed 2009-11-18 00:22:41, Paul Parsons wrote:
> > > Does pressure actually work as expected -- that is not inverted?
> > > Because I need this patch on spitz...  but it may break your
> > > machine...
> > 
> > You are right, the pressure values were being inverted on my hx4700.
> > Pressing hard generates somewhat lower Rt values than pressing lightly.
> > 
> > Since typical hx4700 Rt values are close to (pressure_max/2) anyway,
> > the inverted and non-inverted values were not very different.
> > For example:
> > 
> > Rt      ts->pressure_max-Rt
> > 599     425
> > 562     462
> > 588     436
> > 570     454
> > 
> > So by all means submit your ads7846.c patch; it will not break hx4700.
> 
> Dmitry, those pressure values are reverted on more than one machine,
> and we do not have anyone reporting it works ok for them. Can we
> perhaps just.... fix it?

OK, so we have 4 instances where pressure is inverted and nobody wants
to come out with a non-inverted example... I'll queue for .33 then - .32
it too close to the release.

-- 
Dmitry
