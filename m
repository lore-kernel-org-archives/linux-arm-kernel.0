From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 27 Mar 2015 20:07:50 +0100
Subject: [PATCH 01/13] thermal: Make temperatures consistently unsigned
 long
In-Reply-To: <9hhzj6y217d.fsf@e105922-lin.cambridge.arm.com>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
 <1427385240-6086-2-git-send-email-s.hauer@pengutronix.de>
 <9hhzj6y217d.fsf@e105922-lin.cambridge.arm.com>
Message-ID: <20150327190750.GZ9742@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 27, 2015 at 10:18:14AM +0000, Punit Agrawal wrote:
> Hi Sascha,
> 
> Sascha Hauer <s.hauer@pengutronix.de> writes:
> 
> > The thermal framework uses int, long and unsigned long for temperatures
> > in millicelsius. The majority of functions uses unsigned long, so change
> > the remaining functions to use this type aswell.
> >
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> I'd suggest changing to long instead. It would allow the use of the
> thermal framework in environments where temperatures are below 0C -
> quite easily reached in many parts of the world.

I agree to use a signed type. I also found it not so nice that the thermal
core does not support negative temperatures. I only chose unsigned long
because the patch got smallest that way, but I already expected this
answer ;)
We could also use int instead of long. INT_MAX ?mC is still enough for using
a computer on the surface of the sun (Not for the center though)

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
