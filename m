From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 23 Sep 2010 10:18:21 +0200
Subject: [PATCH] at91sam9g45: fix i2c bus speed
In-Reply-To: <1285147886-17100-1-git-send-email-jacmet@sunsite.dk>
References: <1285147886-17100-1-git-send-email-jacmet@sunsite.dk>
Message-ID: <4C9B0D4D.4050102@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 22/09/2010 11:31, Peter Korsgaard :
> Use a correct udelay value to get bus speed around 100KHz. The udelay
> value was most likely copied from the older devices, but the 9g45
> is signicantly faster (400MHz, DDR, ..), so a udelay of 2 gives a
> bus speed of around 190KHz, which is too fast for some devices.
> A udelay value of 5 gives a bus speed of around 90KHz here.
> 
> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
> ---
>  arch/arm/mach-at91/at91sam9g45_devices.c |    4 ++--

By the way, I suspect that at91sam9g20 has the same issue (400MHz core
also)...

We may also have a look at at91sam9g10 which embeds a 266MHz core....

[..]

Best regards,
-- 
Nicolas Ferre
