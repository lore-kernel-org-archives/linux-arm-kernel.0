From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 22 Apr 2013 21:21:05 +0200
Subject: [PATCH v5 00/14] ARM: samsung-time: Prepare for multiplatform
 support
In-Reply-To: <5175755D.20305@samsung.com>
References: <1365794250-14436-1-git-send-email-t.figa@samsung.com>
 <201304122251.41393.arnd@arndb.de> <5175755D.20305@samsung.com>
Message-ID: <8994400.x1JqGELAnV@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 of April 2013 02:37:33 Kukjin Kim wrote:
> On 04/13/13 05:51, Arnd Bergmann wrote:
> > On Friday 12 April 2013, Tomasz Figa wrote:
> >> This series is an attempt to make the samsung-time clocksource driver
> >> ready for multiplatform kernels. It moves the driver to
> >> drivers/clocksource, cleans it up from uses of static
> >> platform-specific definitions, simplifies timer interrupt handling
> >> and adds Device Tree support.
> >> 
> >> The samsung_pwm clocksource driver is made the master driver, which
> >> exposes a single function to the PWM driver to get required data.
> >> Only
> >> samsung-time driver is reworked to use the master driver at this
> >> time,
> >> since the PWM driver can be already considered broken at the moment
> >> and
> >> needs separate series of several patches to fix and clean it up,
> >> which
> >> I am already working on.
> >> 
> >> Tested on Universal C210 board with Device Tree. Not tested without
> >> Device Tree, since it has been already broken before this series.
> >> Compile tested for other related SoCs.
> > 
> > Acked-by: Arnd Bergmann<arnd@arndb.de>
> 
> Applied, this whole series.

It would be nice if we could still get this for 3.10, but AFAIK it is 
already much too late.

I've discussed this matter with Arnd and the solution that can be accepted 
by arm-soc maintainers is to send a subset of this series, like in the 
patch sent by Arnd (clocksource: add samsung pwm timer driver; it needs 
additional fixes, though.).

Best regards,
Tomasz
