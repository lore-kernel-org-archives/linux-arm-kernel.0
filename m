From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 23 May 2012 12:59:50 -0300
Subject: Booting mx31 on linux-next-20120517
In-Reply-To: <20120523154909.GA17621@S2101-09.ap.freescale.net>
References: <CAOMZO5C2vf-emmk=aALy7VESnBkVAQ23YXkHP31MMK7JQzd3Ag@mail.gmail.com>
 <20120518085922.GQ30400@pengutronix.de>
 <CAOMZO5DNSRCknE2Z-rmUjBsJWaiZdRb=8hrNw2N=u4OsqyX1AQ@mail.gmail.com>
 <3280708.6NjLuBzCWZ@laptop>
 <CAOMZO5DHNXkc9wAMapQgtfPujSEcMvFvuSSZfJPb2nM5fm3sUg@mail.gmail.com>
 <20120523154909.GA17621@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5C9OLagUx+89YYBFBO03vUKir-Ao4BPyhdsKqZSpiavMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn,

On Wed, May 23, 2012 at 12:49 PM, Shawn Guo <shawn.guo@linaro.org> wrote:

> My imx51 babbage stops booting for the same cause. ?And I tracked it
> down a little bit and it goes to regmap patch below.
>
> commit 91b5e741184ea9836cd7d7509e4f9b6eefa27df2
> Author: Marc Reilly <marc@cpdesign.com.au>
> Date: ? Sun Apr 1 16:41:37 2012 +1000
>
> ? ?mfd: Use regmap for the mc13xxx-core register access
>
> ? ?This change converts the mc13xxx core to use regmap rather than direct
> ? ?spi r/w.
> ? ?The spidev member of mc13xxx struct becomes redundant and is removed.
> ? ?Extra debugging aids are added to mc13xxx_reg_rmw.
> ? ?Mutex init is moved to before regmap init.
>
> Marc,
>
> Have you tested the patch with spi access? ?It seems not to me.

The original issue from this thread was solved by this patch:
http://www.spinics.net/lists/arm-kernel/msg176093.html

For the mc13xxx hang, I started another thread:
http://marc.info/?l=linux-kernel&m=133778717002997&w=2

Please check the details there and any help is appreciatted.

Marc told us that he has no hardware to test mc13xxx via SPI.

Regards,

Fabio Estevam
