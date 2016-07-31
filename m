From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 31 Jul 2016 11:12:32 +0200
Subject: [PATCH v2] ARM: pxa: fix GPIO double shifts
In-Reply-To: <1469896245.3998.113.camel@perches.com> (Joe Perches's message of
 "Sat, 30 Jul 2016 09:30:45 -0700")
References: <1469877735-30127-1-git-send-email-robert.jarzmik@free.fr>
 <1469896245.3998.113.camel@perches.com>
Message-ID: <8760rmyxvj.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Joe Perches <joe@perches.com> writes:

> On Sat, 2016-07-30 at 13:22 +0200, Robert Jarzmik wrote:
...zip...
> $ git grep -w charger_wakeup
> arch/arm/mach-pxa/corgi_pm.c:???.charger_wakeup??= corgi_charger_wakeup,
> arch/arm/mach-pxa/sharpsl_pm.c:?????????????????if (sharpsl_pm.machinfo->charger_wakeup() != 0)
> arch/arm/mach-pxa/sharpsl_pm.c:?????????if (sharpsl_pm.machinfo->charger_wakeup())
> arch/arm/mach-pxa/sharpsl_pm.h: unsigned long (*charger_wakeup)(void);
> arch/arm/mach-pxa/spitz_pm.c:???.charger_wakeup???= spitz_charger_wakeup,
...zip...

> It may be better to change the charger_wakeup callback return
> value from unsigned long to bool and modify the other use in
> spitz_pm.c?

You're most probably right. I'll do that for v3.

Cheers.

-- 
Robert
