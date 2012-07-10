From: jbe@pengutronix.de (Juergen Beisert)
Date: Tue, 10 Jul 2012 11:20:52 +0200
Subject: [PATCH] IIO: Add basic MXS LRADC driver
In-Reply-To: <201207091203.09371.marex@denx.de>
References: <1341368129-20468-1-git-send-email-marex@denx.de>
 <201207091119.44952.jbe@pengutronix.de> <201207091203.09371.marex@denx.de>
Message-ID: <201207101120.52892.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

> > When I try to compile
> > your code I get:
> >
> > drivers/staging/iio/adc/mxs-lradc.c:42:40: fatal error:
> > linux/iio/triggered_buffer.h: No such file or directory
>
> You need this patches:
>     iio:kfifo_buf Take advantage of the fixed record size used in IIO
>     iio: kfifo - add poll support.
>
> And use latest -next.

Thanks for the hints. Now it compiles and the driver seems to work.

One thing I do not understand: It does not matter what channel I read 
('in_voltage*_raw'), only interrupt 16 ('mxs-lradc-channel0') counts up. 
Intended?
Or did I a mistake by adding interrupt numbers "<13 14 15 16 17 18 19 20 21 22 
23 24 25>" to the corresponding device tree entry?

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | http://www.pengutronix.de/  |
