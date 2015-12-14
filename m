From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 14 Dec 2015 10:50:55 +0100
Subject: [PATCH v2 1/3] reset: Add shared reset_control_[de]assert variants
In-Reply-To: <20151214093607.GF19456@lukather>
References: <1449848520-27379-1-git-send-email-hdegoede@redhat.com>
 <20151214093607.GF19456@lukather>
Message-ID: <1450086655.3407.23.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 14.12.2015, 10:36 +0100 schrieb Maxime Ripard:
> Hi,
> 
> On Fri, Dec 11, 2015 at 04:41:58PM +0100, Hans de Goede wrote:
> > diff --git a/include/linux/reset.h b/include/linux/reset.h
> > index c4c097d..1cca8ce 100644
> > --- a/include/linux/reset.h
> > +++ b/include/linux/reset.h
> > @@ -11,6 +11,8 @@ int reset_control_reset(struct reset_control *rstc);
> >  int reset_control_assert(struct reset_control *rstc);
> >  int reset_control_deassert(struct reset_control *rstc);
> >  int reset_control_status(struct reset_control *rstc);
> > +int reset_control_assert_shared(struct reset_control *rstc);
> > +int reset_control_deassert_shared(struct reset_control *rstc);
> 
> Shouldn't that be handled in reset_control_get directly?

This is about different expectations of the caller.
A driver calling reset_control_assert expects the reset line to be
asserted after the call. A driver calling reset_control_assert_shared
just signals that it doesn't care about the state of the reset line
anymore.
We could just as well call the two new functions
reset_control_deassert_get and reset_control_deassert_put.

regards
Philipp
