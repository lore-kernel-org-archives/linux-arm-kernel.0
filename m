From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 06 Jan 2014 18:42:51 +0100
Subject: [PATCH 1/3] reset: Add of_reset_control_get
In-Reply-To: <20131221094213.03658852@skate>
References: <1387575669-21253-1-git-send-email-maxime.ripard@free-electrons.com>
 <1387575669-21253-2-git-send-email-maxime.ripard@free-electrons.com>
 <20131221094213.03658852@skate>
Message-ID: <1389030171.5590.31.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag, den 21.12.2013, 09:42 +0100 schrieb Thomas Petazzoni:
> Maxime, Philipp,
> 
> On Fri, 20 Dec 2013 22:41:07 +0100, Maxime Ripard wrote:
> > In some cases, you might need to deassert from reset an hardware block that
> > doesn't associated to a struct device (CPUs, timers, etc.).
> > 
> > Add a small helper to retrieve the reset controller from the device tree
> > without the need to pass a struct device.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/reset/core.c  | 39 ++++++++++++++++++++++++++++++---------
> >  include/linux/reset.h |  4 ++++
> >  2 files changed, 34 insertions(+), 9 deletions(-)
> 
> I'd like to add that I have the exact same need as Maxime. Maxime needs
> of_reset_control_get() for timers, and in my case, I need it for CPUs,
> since I associated a reset controller to CPU nodes in my DT.
> 
> Funnily, even though Maxime and I work like 3 meters away from each
> other, both of us came up independently with almost exactly the same
> implementation to solve the exact same problem, without talking to each
> other about this need. It's only yesterday that we discovered we've had
> to solve the same problem.
> 
> So, definitely looking forward to seeing the feedback about this.
> 
> Thanks!

This looks like a useful addition. I'll reorder the GPIO reset patch for
this.

regards
Philipp
