From: tony@atomide.com (Tony Lindgren)
Date: Thu, 8 Sep 2016 11:41:12 -0700
Subject: Regmap regression in next caused by of_iomap change
Message-ID: <20160908184111.vj3sb2ik6ydehkag@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Looks like commit 39de2c4275a9 ("mfd: syscon: Make use of of_iomap")
makes at least MMC PBIAS regulator stop working on omap3.

That's probably because of_syscon_register uses the now unintialized
struct resource res to set syscon_config.max_register.

I have a strange deja vu feeling that we've been through this
before :) See commit ca668f0edfae ("mfd: syscon: Set regmap max_register
in of_syscon_register")

Maybe we should add comments there instead?

Regards,

Tony
