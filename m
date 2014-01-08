From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 8 Jan 2014 11:38:43 +0100
Subject: [PATCH 1/3] reset: Add of_reset_control_get
In-Reply-To: <1389030171.5590.31.camel@pizza.hi.pengutronix.de>
References: <1387575669-21253-1-git-send-email-maxime.ripard@free-electrons.com>
 <1387575669-21253-2-git-send-email-maxime.ripard@free-electrons.com>
 <20131221094213.03658852@skate>
 <1389030171.5590.31.camel@pizza.hi.pengutronix.de>
Message-ID: <20140108103843.GA2941@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On Mon, Jan 06, 2014 at 06:42:51PM +0100, Philipp Zabel wrote:
> Am Samstag, den 21.12.2013, 09:42 +0100 schrieb Thomas Petazzoni:
> > Maxime, Philipp,
> > 
> > On Fri, 20 Dec 2013 22:41:07 +0100, Maxime Ripard wrote:
> > > In some cases, you might need to deassert from reset an hardware block that
> > > doesn't associated to a struct device (CPUs, timers, etc.).
> > > 
> > > Add a small helper to retrieve the reset controller from the device tree
> > > without the need to pass a struct device.
> > > 
> > > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > > ---
> > >  drivers/reset/core.c  | 39 ++++++++++++++++++++++++++++++---------
> > >  include/linux/reset.h |  4 ++++
> > >  2 files changed, 34 insertions(+), 9 deletions(-)
> > 
> > I'd like to add that I have the exact same need as Maxime. Maxime needs
> > of_reset_control_get() for timers, and in my case, I need it for CPUs,
> > since I associated a reset controller to CPU nodes in my DT.
> > 
> > Funnily, even though Maxime and I work like 3 meters away from each
> > other, both of us came up independently with almost exactly the same
> > implementation to solve the exact same problem, without talking to each
> > other about this need. It's only yesterday that we discovered we've had
> > to solve the same problem.
> > 
> > So, definitely looking forward to seeing the feedback about this.
> > 
> > Thanks!
> 
> This looks like a useful addition. I'll reorder the GPIO reset patch for
> this.

How do you want to get this merged? You'll probably want to take this
patch, and patches 2/3 and 3/3 depend on some patches merged by Daniel
Lezcano (that I forgot to CC on this, I'll resend).

Maybe the best way would be simply to merge this one for 3.14 through
your branch, and merge the two other patches in 3.15.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140108/376b280d/attachment.sig>
