From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sun, 15 Nov 2009 23:09:36 +0100
Subject: [rtc-linux] Re: [PATCH] Remove __raw_* accessors from PL031 RTC
In-Reply-To: <20091115213544.GA1370@pengutronix.de>
References: <1258009987-11317-1-git-send-email-linus.walleij@stericsson.com>
	<20091115213544.GA1370@pengutronix.de>
Message-ID: <63386a3d0911151409k47a8847pc7e5cd7b8d73f8c4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/11/15 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:

> arch/arm/include/asm/io.h defines writel like so:
>
> ? ? ? ?#define writel(v,c) ? ? ? ? ? ? __raw_writel((__force __u32) \
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?cpu_to_le32(v),__mem_pci(c))
>
> So this change isn't a noop on big-endian systems that define __mem_pci.
> I don't know how many of these exist though.

Yeah it's not supposed to be a noop, it's supposed to be a bugfix, all
other PrimeCell drivers use readl()/writel(). The assumption is that PrimeCell
registers shall always be accessed LE, and AFAICT that's what the above
macro does.

Linus
