From: jbe@pengutronix.de (Juergen Borleis)
Date: Fri, 24 Apr 2015 12:10:43 +0200
Subject: [rtc-linux] [PATCH 1/5] RTC/i.MX/DryIce: add some background info
 about the states the machine can be in
In-Reply-To: <20150421220942.GB8539@piout.net>
References: <1429002716-19821-1-git-send-email-jbe@pengutronix.de>
 <1429002716-19821-2-git-send-email-jbe@pengutronix.de>
 <20150421220942.GB8539@piout.net>
Message-ID: <201504241210.43768.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

On Wednesday 22 April 2015 00:09:42 Alexandre Belloni wrote:
> [...]
> > ---
> >  drivers/rtc/rtc-imxdi.c | 43 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >
> > diff --git a/drivers/rtc/rtc-imxdi.c b/drivers/rtc/rtc-imxdi.c
> > index c666eab..8750477 100644
> > --- a/drivers/rtc/rtc-imxdi.c
> > +++ b/drivers/rtc/rtc-imxdi.c
> > @@ -129,6 +129,49 @@ struct imxdi_dev {
> >  	struct work_struct work;
> >  };
> >
> > +/* Some background:
> > + *
> > + * The DryIce unit is a complex security/tamper monitor device. To be able do
> > + * its job in a useful manner it runs a bigger statemachine to bring it into
> > + * security/tamper failure state and once again to bring it out of this state.
> > + * 
> > + * This unit can be in one of three states:
> > + *
> > + * - "NON-VALID STATE"
> > + *   always after the battery power was removed
> > + * - "FAILURE STATE"
> > + *   if one of the enabled security events have happend
>
>                                  has happened ^
>
> > + * - "VALID STATE"
> > + *   if the unit works as expected
> > + *
> > + * Everything stops when the unit enters the failure state including the
> > RTC + * counter (to be able to detect the time the security event
> > happend).
>
>                                                        happened ^
> [...]

Thanks for the feedback. Fixed in the next version.

Regards,
Juergen
-- 
Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| Juergen Borleis ? ? ? ? ? ? |
Industrial Linux Solutions               ? ? ?| http://www.pengutronix.de/  |
