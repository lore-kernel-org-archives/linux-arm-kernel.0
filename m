From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 14 Mar 2017 14:45 +0100
Subject: [PATCH v2 3/8] ARM: dts: exynos: Fix watchdog reset on Exynos4412
In-Reply-To: <CAJKOXPcoP7c=TTFtWqBLMXT0BS_yi3fpu8X3q4sxCTM9m=mPmw@mail.gmail.com>
References: <20170311172527.16368-1-krzk@kernel.org>
 <6788694.7QfyuOlrPv@amdc3058>
 <CAJKOXPcoP7c=TTFtWqBLMXT0BS_yi3fpu8X3q4sxCTM9m=mPmw@mail.gmail.com>
 <CGME20170314134503epcas1p178241245d202edf9f3ea5885c605ffb6@epcas1p1.samsung.com>
Message-ID: <1510739.WtREN49XT5@amdc3058>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, March 14, 2017 03:09:25 PM Krzysztof Kozlowski wrote:
> On Tue, Mar 14, 2017 at 3:03 PM, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> >
> > Hi,
> >
> > On Saturday, March 11, 2017 07:25:22 PM Krzysztof Kozlowski wrote:
> >> The Exynos4412 has the same watchdog as newer SoCs (e.g. Exynos5250).
> >> Just like the others, for working it requires additional steps in Power
> >> Management Unit: unmasking the reset request and enabling the system
> >> reset.  Without these additional steps in PMU, the watchdog will not be
> >> able to reset the system on expiration event.
> >>
> >> Change the compatible of Exynos4412 watchdog device node to
> >> samsung,exynos5250-wdt which includes the additional PMU steps.
> >
> > This is going to confuse people.  How's about doing it cleanly
> > (by adding samsung,exynos4412-wdt compatible and convert existing
> > users to use instead)?
> 
> I don't find usage of 5250 in Exynos4412 DTS as confusing because
> since long time I do not threat these numbers as having any meaning
> (e.g. 3250 is newer...). Yes, we can duplicate the compatible for that
> purpose. Care to send a patch for this?

I don't buy this argument. The point is not in the number itself
but in the fact that you as developer know than 3250 is newer than
4412 (the same way as you know that 5250 is also newer than 4412).
This convention is used for all Exynos bindings so please don't
break it.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
