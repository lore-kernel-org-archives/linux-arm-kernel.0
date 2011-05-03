From: bn@niasdigital.com (Ben Nizette)
Date: Tue, 3 May 2011 11:47:59 +1000
Subject: [PATCH 1/4] drivers: create a pinmux subsystem
In-Reply-To: <1304363786-30376-1-git-send-email-linus.walleij@stericsson.com>
References: <1304363786-30376-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <975406B8-5A4D-4C71-85D0-A4352069CB6D@niasdigital.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 03/05/2011, at 5:16 AM, Linus Walleij wrote:

> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This creates a subsystem for handling of pinmux devices. These are
> devices that enable and disable groups of pins on primarily PGA and
> BGA type of chip packages and common in embedded systems.
> 
> This is being done to depopulate the arch/arm/* directory of such
> custom drivers and try to abstract the infrastructure they all
> need. See the Documentation/pinmux.txt file that is part of this
> patch for more details.

Haven't reviewed the actual code but at an interface level it seems
sane.  It'd be nice to actually implement a driver for some nutbars SoC
and make sure it all shakes out but in the first instance I can't see
any problems.

Leaving it orthogonal to gpio is a great move conceptually and if it does
need to be tied back to the gpio_request() interface later then, well,
we'll cross that bridge when we come to it.

Thanks for your work in this area, looking good.

	--Ben.
