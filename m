From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 22 Apr 2015 01:26:15 +0200
Subject: [rtc-linux] [PATCH 2nd try] RTC/i.MX/DryICE: add recovery
 routines to the driver
In-Reply-To: <1429002716-19821-1-git-send-email-jbe@pengutronix.de>
References: <1429002716-19821-1-git-send-email-jbe@pengutronix.de>
Message-ID: <20150421232615.GD8539@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 14/04/2015 at 11:11:51 +0200, Juergen Borleis wrote :
> 2nd try, this time with a cover letter... m(
> 
> The built-in RTC unit on some i.MX SoCs isn't an RTC only. It is also a tamper
> monitor unit which can keep some keys. When it does its tamper detection job

Does it have more functions? I would say that it also holds some keys
but I don't have a handy Freescale representative to contact ;)

I'm fine getting that unlocking done in the RTC driver but maybe in the
future, it will be necessary to handle that in an MFD driver when adding
support for the other functions.

> and a tamper violation is detected, this RTC unit locks completely including
> the real-time counter. In this state the unit is completely useless. The only
> way to bring it out of this locked state is a power on reset. At the next boot
> time some flags signals the tamper violation and a specific register access
> sequence must be done to finaly bring this unit into life again. Until this is
> done, there is no way to use it again as an RTC.
> But also without any enabled tamper detection sometimes this unit tends to
> lock. And in this case the same steps must be done to bring it into life
> again.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
