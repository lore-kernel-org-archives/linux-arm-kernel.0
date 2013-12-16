From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 16 Dec 2013 13:37:06 -0800
Subject: [PATCHv4] rtc: Add support for Intersil ISL12057 I2C RTC chip
In-Reply-To: <1dec5992db795b61e91e0abf910dee7fce322ccc.1387227955.git.arno@natisbad.org>
References: <1dec5992db795b61e91e0abf910dee7fce322ccc.1387227955.git.arno@natisbad.org>
Message-ID: <20131216213706.GA8527@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 16, 2013 at 10:17:47PM +0100, Arnaud Ebalard wrote:
> 
> Intersil ISL12057 I2C RTC chip also supports two alarms. This patch
> only adds support for basic RTC functionalities (i.e. getting and
> setting time). Tests have been performed on NETGEAR ReadyNAS 102 w/
> startup/shutdown scripts, hwclock, ntpdate and openntpd.
> 
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>

Here is a snippet from the saved patch:

 obj-$(CONFIG_RTC_DRV_IMXDI)    +=3D rtc-imxdi.o
 obj-$(CONFIG_RTC_DRV_ISL1208)  +=3D rtc-isl1208.o
 obj-$(CONFIG_RTC_DRV_ISL12022) +=3D rtc-isl12022.o
+obj-$(CONFIG_RTC_DRV_ISL12057)  +=3D rtc-isl12057.o
 obj-$(CONFIG_RTC_DRV_JZ4740)   +=3D rtc-jz4740.o
 obj-$(CONFIG_RTC_DRV_LP8788)   +=3D rtc-lp8788.o
 obj-$(CONFIG_RTC_DRV_LPC32XX)  +=3D rtc-lpc32xx.o

Something is adding those '3D' after each '=' into the patch.

On a side note, even though it is hard to see, it seems you use two spaces
instead of a tab above, and that you do the same with other defines (unless the
mailer replaced tabs with spaces).

In general, the widely used form for defines is

#define<space>MY_DEFINE<tab>definition<tab>/* this is a comment */

Also, I think

+static struct i2c_driver isl12057_driver;

is unnecessary. But I'd really like to have a closer look again after you fixed
the =3D issue ...

Thanks,
Guenter
