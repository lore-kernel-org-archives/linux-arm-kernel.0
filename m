From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 31 Aug 2010 12:07:58 +0100
Subject: [PATCH] mmc: move regulator handling to core
In-Reply-To: <AANLkTim+cOSt=kjXXh_w+b4mzCiZN76HQ3az7SJKmOxR@mail.gmail.com>
References: <1259844390-10541-1-git-send-email-daniel@caiaq.de>
	<20100827190306.GB20407@void.printf.net>
	<AANLkTi=20KrUy334JRmMYwK7rbaVYrYCqW-BHZYGPrwT@mail.gmail.com>
	<20100829132711.GB10233@opensource.wolfsonmicro.com>
	<AANLkTim+cOSt=kjXXh_w+b4mzCiZN76HQ3az7SJKmOxR@mail.gmail.com>
Message-ID: <20100831110758.GD20849@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 29, 2010 at 05:30:48PM +0200, Linus Walleij wrote:
> 2010/8/29 Mark Brown <broonie@opensource.wolfsonmicro.com>:

> > This seems like the wrong approach; if there's a problem it'd seem much
> > better to fix the core code that everything is sharing rather than
> > factor it out - the location of the code is orthogonal to its
> > helpfulness.

> I actually did not move the essential regulator bits out just enable/disable,
> so that these were in the sites where the regulators were actually
> enabled/disabled in respective driver. That makes the internal
> regulator reference count do the trick.

I'm not sure what "the sites where the regulators were actually
enabled/disabled in respective driver" are but my understanding was that
there's a bit of an issue here in that the MMC core does not guarantee
balanced enable/disable calls.
