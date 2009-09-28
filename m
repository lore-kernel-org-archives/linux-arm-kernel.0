From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Mon, 28 Sep 2009 21:00:01 +0200
Subject: [PATCH] Make MMCI driver compile without gpiolib
In-Reply-To: <20090927153108.GA20093@n2100.arm.linux.org.uk>
References: <1251276988-27882-1-git-send-email-linus.walleij@stericsson.com>
	<20090927153108.GA20093@n2100.arm.linux.org.uk>
Message-ID: <63386a3d0909281200m1da30d22h4ea4fb72278941de@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hm thinking back at this:

2009/9/27 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> The real problem is that U300 doesn't implement gpio_is_valid() -
> which is part of the GPIO API and not specific to GPIOLIB.

None of the GPIO drivers in drivers/gpio implement gpio_is_valid()
though they all select GPIOLIB which in turn selects GENERIC_GPIO.

With one of them being the PL061 this means that the not so
unlikely combination of PL061+PL180 will fail to compile (even
though I'm not aware of such a platform for the time being).

Is it worth taking a run over drivers/gpio and try to fix this or
atleast the PL061 driver? I can have a look at it.

Yours,
Linus Walleij
