From: jbe@pengutronix.de (Juergen Borleis)
Date: Fri, 24 Apr 2015 12:32:30 +0200
Subject: [rtc-linux] [PATCH 2nd try] RTC/i.MX/DryICE: add recovery
 routines to the driver
In-Reply-To: <20150421232615.GD8539@piout.net>
References: <1429002716-19821-1-git-send-email-jbe@pengutronix.de>
 <20150421232615.GD8539@piout.net>
Message-ID: <201504241232.30104.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

On Wednesday 22 April 2015 01:26:15 Alexandre Belloni wrote:
> On 14/04/2015 at 11:11:51 +0200, Juergen Borleis wrote :
> > 2nd try, this time with a cover letter... m(
> >
> > The built-in RTC unit on some i.MX SoCs isn't an RTC only. It is also a
> > tamper monitor unit which can keep some keys. When it does its tamper
> > detection job
>
> Does it have more functions? I would say that it also holds some keys
> but I don't have a handy Freescale representative to contact ;)

Yes it can hold some keys and will delete them if it detects a security 
violation via its tamper detection feature.

> I'm fine getting that unlocking done in the RTC driver but maybe in the
> future, it will be necessary to handle that in an MFD driver when adding
> support for the other functions.

This change set just makes the RTC work again. Observation was, *sometimes* and 
*somehow* this unit tends to lock even if no of these tamper detection 
features were enabled nor the externals signals (to detect these security 
violations) were used.

Regards,
Juergen

-- 
Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| Juergen Borleis ? ? ? ? ? ? |
Industrial Linux Solutions               ? ? ?| http://www.pengutronix.de/  |
