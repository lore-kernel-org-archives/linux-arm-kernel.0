From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sun, 29 Aug 2010 17:30:48 +0200
Subject: [PATCH] mmc: move regulator handling to core
In-Reply-To: <20100829132711.GB10233@opensource.wolfsonmicro.com>
References: <1259844390-10541-1-git-send-email-daniel@caiaq.de>
	<20100827190306.GB20407@void.printf.net>
	<AANLkTi=20KrUy334JRmMYwK7rbaVYrYCqW-BHZYGPrwT@mail.gmail.com>
	<20100829132711.GB10233@opensource.wolfsonmicro.com>
Message-ID: <AANLkTim+cOSt=kjXXh_w+b4mzCiZN76HQ3az7SJKmOxR@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/8/29 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Sat, Aug 28, 2010 at 04:48:58PM +0200, Linus Walleij wrote:
>> 2010/8/27 Chris Ball <cjb@laptop.org>:
>
>> > Looks like this patch got dropped because of the missing modifications
>> > to arch/arm/mach-omap2/mmc-twl4030.c. ?Are we still interested in the
>> > patch otherwise, and can anyone help with that?
>
>> Actually just before the summer I submitted something not quite similar:
>> I moved all regulator handling *out* of the MMC core because I didn't
>> trust the way reference counting was being handled.
>
> This seems like the wrong approach; if there's a problem it'd seem much
> better to fix the core code that everything is sharing rather than
> factor it out - the location of the code is orthogonal to its
> helpfulness.

I actually did not move the essential regulator bits out just enable/disable,
so that these were in the sites where the regulators were actually
enabled/disabled in respective driver. That makes the internal
regulator reference count do the trick.

I can get that patch into shape easily, if for nothing else it's a nice
discussion item.

Yours,
Linus Walleij
