From: pavel@denx.de (Pavel Machek)
Date: Thu, 18 Jul 2013 13:25:55 +0200
Subject: [PATCH v8] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <51E719A6.6070105@wwwdotorg.org>
References: <1369904940-716-1-git-send-email-p.zabel@pengutronix.de>
 <20130716015038.GD28375@S2101-09.ap.freescale.net>
 <51E4BF98.8030604@wwwdotorg.org>
 <20130716041056.GA30067@S2101-09.ap.freescale.net>
 <51E56AA7.7020103@wwwdotorg.org>
 <20130717030246.GA4541@S2101-09.ap.freescale.net>
 <51E6CCE4.20705@wwwdotorg.org>
 <20130717213836.GA13324@amd.pavel.ucw.cz>
 <51E719A6.6070105@wwwdotorg.org>
Message-ID: <20130718112555.GB1021@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >>> I do not quite follow the argument here.  I agree with you that
> >>> deferred probe is the approach to solve dependencies.  But it does not
> >>> necessarily mean that initcall can not be used to help it save some
> >>> nasty or nested deferring.  Deferred probe and initcalls are not two
> >>> mutually exclusive mechanisms but two which can help each other.
> >>
> >> My understanding is that deferred probe was implemented specifically to
> >> avoid having to, or allowing, the use of initcall levels to determine
> >> probe order.
> >>
> >> However, if someone closely associated with the implementation of
> >> deferred probe (e.g. Grant, or a device core maintainer) is willing to
> >> step up and say I'm wrong, I'll drop my objection.
> > 
> > AFAIR, defered probing is known to be a "hack" by its authors. We
> > should still try to get initcall levels right...
> 
> I don't /think/ it was the concept of deferred probe that was considered
> hacky, but perhaps just the first proof-of-concept implementation, and
> any hackiness was presumably solved before the feature was merged.

Well...

http://lwn.net/Articles/485194/

From:		Grant Likely <grant.likely@secretlab.ca>
To:		      linux-kernel at vger.kernel.org
Subject:		[PATCH] drivercore: Add driver probe deferral
mechanism
Date:		Mon, 5 Mar 2012 08:47:41 -0700
Message-ID:
<1330962461-9061-1-git-send-email-grant.likely@secretlab.ca>
...

I know that not everybody is happy with this approach, but I've yet to
see a better alternative.  However, it is *really easy* to find all
the
users of deferred probe since any user must return -EPROBE_DEFER
explicitly.
If/when a better approach is found, all the users will be easy to find
and modify.

...

It sound to me like keeping ammount of -EPROBE_DEFER to minimum is
still preferred.

							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
