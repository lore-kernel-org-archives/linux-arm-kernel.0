From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 12 Mar 2014 21:54:48 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAzLzNdIHNwaTogcHNkZXY6IGFkZCBwYXNzaXZlIHNlcmlh?=
 =?UTF-8?B?bCBkcml2ZXI=?=
In-Reply-To: <1394639617-26917-4-git-send-email-m.grzeschik@pengutronix.de>
References: <1394639617-26917-1-git-send-email-m.grzeschik@pengutronix.de>
 <1394639617-26917-4-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1394646888.880576709@f181.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?????, 12 ????? 2014, 16:53 +01:00 ?? Michael Grzeschik <m.grzeschik@pengutronix.de>:
> This patch introduces the psdev driver. It is used to communicate to an
> Altera passive serial connected FPGA by writing into an character
> device.
> 
> It simply initates the protocol on open and clocks the data into the
> FPGA by using the underlying SPI bus on write. The used SPI bus can also
> be an bitbang SPI bus. On close it will check for the response of the
> FPGA and tells if the write process was successful.

As a suggestion, I want to advise you to use GPIO functions based on
descriptors (xx_gpiod_xx()) for the new drivers.
This will simplify code a bit, allows you to use the driver for non-DT boards
without creating any new global headers for platform_data and eliminate
the possible confusion with active levels for these GPIOs in the future.

---
