From: ml.lawnick@gmx.de (Michael Lawnick)
Date: Wed, 17 Jun 2015 13:09:53 +0200
Subject: [PATCH] i2c: omap: improve duty cycle on SCL
In-Reply-To: <1434482276-1210-1-git-send-email-balbi@ti.com>
References: <1434482276-1210-1-git-send-email-balbi@ti.com>
Message-ID: <55815581.80807@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 16.06.2015 um 21:17 schrieb Felipe Balbi:
> With this patch we try to be as close to 50%
> duty cycle as possible. The reason for this
> is that some devices present an erratic behavior
> with certain duty cycles.
>
> One such example is TPS65218 PMIC which fails
> to change voltages when running @ 400kHz and
> duty cycle is lower than 34%.
>
> The idea of the patch is simple:
>
> calculate desired scl_period from requested scl
> and use 50% for tLow and 50% for tHigh.
...
Hmm, and what's about  Philips I2C specification 2.1, Jan 2000, Table 5?

> PARAMETER                       SYMBOL  STANDARD-MODE   FAST-MODE     UNIT
>                                           MIN. MAX.     MIN. MAX.
> LOW period of the SCL clock     tLOW      4.7   ?       1.3   ?       ?s
> HIGH period of the SCL clock    tHIGH     4.0   ?       0.6   ?       ?s

Your signal is in spec (0.85 ?s high, 1,65 low).
Maybe your TPS65218 is just buggy or signals are bad?

-- 

KR
Michael
