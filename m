From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 26 May 2014 17:28:35 +0200
Subject: [PATCH 2/4] cpufreq: add i.MX5 cpufreq driver
In-Reply-To: <CAKohponvWLVfBL06HURnTq4nmdKjROV-bd4pVcbNmsAUYYC+nA@mail.gmail.com>
References: <1401099308-9658-1-git-send-email-l.stach@pengutronix.de>
 <1401099308-9658-2-git-send-email-l.stach@pengutronix.de>
 <CAKohpoksbFHyX=r0=URMedJNi68c3xAX4OrXzSFqgf1-bCm4+Q@mail.gmail.com>
 <1401101131.4829.29.camel@weser.hi.pengutronix.de>
 <CAKohponTUsYLf-8_iSnttwK8oXyJEZVWpF+a=vLC7r_jZ8AzOQ@mail.gmail.com>
 <1401107748.4829.39.camel@weser.hi.pengutronix.de>
 <CAKohpo=ncHUmtJOEw4FZG1BWUSuiQK4n+ETEMJWJj9UoPz2cnw@mail.gmail.com>
 <1401109863.4829.46.camel@weser.hi.pengutronix.de>
 <CAKohponzJma6yNueMef2Q4k+qT-n7boV0tx0pCqjFmuQWj6TXg@mail.gmail.com>
 <1401112697.4829.56.camel@weser.hi.pengutronix.de>
 <CAKohponvWLVfBL06HURnTq4nmdKjROV-bd4pVcbNmsAUYYC+nA@mail.gmail.com>
Message-ID: <1401118115.4829.60.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 26.05.2014, 20:52 +0530 schrieb Viresh Kumar:
> On 26 May 2014 19:28, Lucas Stach <l.stach@pengutronix.de> wrote:
> > Right, the OPP in my example define the minimum required voltage for
> > each frequency. This is in accordance to the OPP binding. But for this
> > chip the datasheet explicitly says that it is ok to power the cpu rail
> > with up to 1.4V, regardless of the current operating frequency. So this
> > 1.4V is really the upper bound I would like to pass to the regulator
> > framework. This ensures that the driver still works properly even if the
> > external regulator can't scale down to the minimum (or in other words
> > optimal) voltage.
> 
> One more query. You have mentioned earlier and I just wanted to confirm
> this. In your platform/board regulator only supports one voltage, i.e. 1.4 uV,
> and it we can't get lower values out of regulator ?
> 
> If that's the case, why are you looking to use regulator at all?

The platform I'm working on supports cpu rail voltage regulation just
fine.
I just want to make sure that the driver works properly on platforms
where this isn't the case. As the datasheet explicitly allows this case
I want to make sure to not introduce a software only restriction, where
there isn't any in hardware.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
