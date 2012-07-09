From: marex@denx.de (Marek Vasut)
Date: Mon, 9 Jul 2012 12:03:09 +0200
Subject: [PATCH] IIO: Add basic MXS LRADC driver
In-Reply-To: <201207091119.44952.jbe@pengutronix.de>
References: <1341368129-20468-1-git-send-email-marex@denx.de>
 <201207091119.44952.jbe@pengutronix.de>
Message-ID: <201207091203.09371.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Juergen Beisert,

> Hi Marek,
> 
> Marek Vasut wrote:
> > This driver is very basic. It supports userland trigger, buffer and
> > raw access to channels. The support for delay channels is missing
> > altogether.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: Wolfgang Denk <wd@denx.de>
> > Cc: Juergen Beisert <jbe@pengutronix.de>
> > ---
> > 
> >  drivers/staging/iio/adc/Kconfig     |   12 +
> >  drivers/staging/iio/adc/Makefile    |    1 +
> >  drivers/staging/iio/adc/mxs-lradc.c |  619
> >  +++++++++++++++++++++++++++++++++++ 3 files changed, 632 insertions(+)
> >  create mode 100644 drivers/staging/iio/adc/mxs-lradc.c
> > 
> > [...]
> 
> sorry for the delay, too much work at the same time.

You tell me.

> When I try to compile
> your code I get:
> 
> drivers/staging/iio/adc/mxs-lradc.c:42:40: fatal error:
> linux/iio/triggered_buffer.h: No such file or directory

You need this patches:
    iio:kfifo_buf Take advantage of the fixed record size used in IIO
    iio: kfifo - add poll support.

And use latest -next.

> 
> Regards,
> Juergen

Best regards,
Marek Vasut
