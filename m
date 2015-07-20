From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 20 Jul 2015 10:03:14 +0200
Subject: [RFC PATCH 05/15] pwm: introduce default period and polarity
 concepts
In-Reply-To: <20150702094955.4b1c9254@bbrezillon>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <1435738921-25027-6-git-send-email-boris.brezillon@free-electrons.com>
 <20150702064445.GC11824@pengutronix.de>
 <20150702094955.4b1c9254@bbrezillon>
Message-ID: <20150720080313.GF29614@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 02, 2015 at 09:49:55AM +0200, Boris Brezillon wrote:
> On Thu, 2 Jul 2015 08:44:45 +0200
> Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:
> 
> > On Wed, Jul 01, 2015 at 10:21:51AM +0200, Boris Brezillon wrote:
> > > When requested by a user, the PWM is assigned a default period and polarity
> > > extracted from the DT, the platform data or statically set by the driver.
> > > Those default values are currently stored in the period and polarity
> > > fields of the pwm_device struct, but they will be stored somewhere else
> > > once we have introduced the architecture allowing for hardware state
> > > retrieval.
> > > 
> > > The pwm_set_default_polarity and pwm_set_default_period should only be
> > > used by PWM drivers or the PWM core infrastructure to specify the
> > > default period and polarity values.
> > Would it make sense to put the prototypes of
> > pwm_set_default_p{olarity,eriod} into (say) drivers/pwm/pwm-private.h
> > then?
> > 
> 
> Yes, definitely. I was thinking about moving those functions/prototypes
> into include/linux/pwm-provider.h, but I'm fine with
> drivers/pwm/pwm-private.h too.
> 
> Thierry, any opinion ?

I'm not sure I see the need for this. If they are the default values and
drivers have no need to change them, then storing them in the regular
period and polarity fields seems just fine (they'll be propagated into
new state objects as they get created).

And if the driver has a need to change them, then why would it ever care
about the default values?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150720/b044f07f/attachment.sig>
