From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 15 Jul 2010 00:37:08 +0200
Subject: [PATCH] RFC: U300 clock updates to match PrimeCell clocking
In-Reply-To: <20100714190311.GA18649@debian>
References: <1279065807-22238-1-git-send-email-linus.walleij@stericsson.com>
	<20100714190311.GA18649@debian>
Message-ID: <AANLkTikas8Xnlajfr3QYvlnfC_Gbs1MQRjVNLsFMdByy@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/14 Rabin Vincent <rabin@rab.in>:

> In order to be able to remove your clock enabling around the
> amba_device_register() calls, the busclk get/enabling would need to be
> also added around the peripheral ID read in amba_device_register(), not
> just before the probe call, where Russell's patch added it.

Of course. You see everything...
Russell seems to be onto it.

Rabin do you have a rough enough idea of how the ahb_pclock and
e.g. SSPCLK are routed to different PRCMU things in the U8500?
IIRC what we have registered there right now are actually mostly
the correct SSPCLK etc for external clocking, but we might want to
add the ahb_pclk references as well.

Yours,
Linus Walleij
