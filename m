From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 19 Apr 2012 19:30:20 +0800
Subject: irq_to_gpio support
Message-ID: <20120419113019.GB26682@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant & Linus

I saw gpio lib didn't provide irq_to_gpio support. Are we dropping it?
git grep irq_to_gpio still return a lot of things.

I'm looking at drivers/input/touchscreen/egalax_ts.c driver.
It failed to compile without irq_to_gpio. It's a i2c client device and
use irq line configured as gpio to wakeup touchscreen controller.
If we don't have irq_to_gpio, I'm afraid it has to use plat data or
of property to pass gpio number.

Thanks
Richard
