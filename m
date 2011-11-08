From: mirqus@gmail.com (=?ISO-8859-2?Q?Micha=B3_Miros=B3aw?=)
Date: Tue, 8 Nov 2011 21:42:56 +0100
Subject: [PATCH 2/5] dma i.MX: remove individual SOC dependency
In-Reply-To: <1314168072-13822-3-git-send-email-s.hauer@pengutronix.de>
References: <1314168072-13822-1-git-send-email-s.hauer@pengutronix.de>
 <1314168072-13822-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <CAHXqBFKps1jsaKCr9yqQY72zAQHT6HU78eJ+adbYfnhRhkKQog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/8/24 Sascha Hauer <s.hauer@pengutronix.de>:
> The individual SoC dependency in Kconfig hardly scales anymore.
> Instead of having such a fine grained dependency just depend
> on ARCH_MXC and risk that the uninformed user has to look in
> the help text to figure out which driver is the correct one.
[...]
> ?config MX3_IPU
> ? ? ? ?bool "MX3x Image Processing Unit support"
> - ? ? ? depends on ARCH_MX3
> + ? ? ? depends on ARCH_MXC
> ? ? ? ?select DMA_ENGINE
> ? ? ? ?default y
> ? ? ? ?help

You could instead make it depend on HAVE_MX3_IPU and select this
symbol from relevant model config. Leaving it for the users is making
every one of them redo the work you already did.

Best Regards,
Micha? Miros?aw
