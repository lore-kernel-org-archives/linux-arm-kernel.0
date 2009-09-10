From: bart.vanassche@gmail.com (Bart Van Assche)
Date: Thu, 10 Sep 2009 12:52:17 +0200
Subject: [PATCH 2/4] i2c/chips: Remove deprecated pcf8575-driver
In-Reply-To: <1252531371-14866-3-git-send-email-w.sang@pengutronix.de>
References: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
	<1252531371-14866-3-git-send-email-w.sang@pengutronix.de>
Message-ID: <e2e108260909100352l2a30438fj9f0297c1974c0192@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 9, 2009 at 11:22 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
>
> The pcf8575-driver in drivers/i2c/chips which just exports its register to
> sysfs is superseeded by drivers/gpio/pcf857x.c which properly uses the gpiolib.
> As this driver has been deprecated for more than a year, finally remove it.
>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Bart Van Assche <bart.vanassche@gmail.com>
> Cc: Jean Delvare <khali@linux-fr.org>
> ---
> ?Documentation/i2c/chips/pcf8575 | ? 69 --------------
> ?drivers/i2c/chips/Kconfig ? ? ? | ? 18 ----
> ?drivers/i2c/chips/Makefile ? ? ?| ? ?1 -
> ?drivers/i2c/chips/pcf8575.c ? ? | ?198 ---------------------------------------
> ?4 files changed, 0 insertions(+), 286 deletions(-)
> ?delete mode 100644 Documentation/i2c/chips/pcf8575
> ?delete mode 100644 drivers/i2c/chips/pcf8575.c

This patch removes the documentation file
Documentation/i2c/chips/pcf8575 while there is no documentation under
Documentation/ for the drivers/gpio/pcf857x.c driver. Shouldn't proper
documentation for the pcf857x driver be added to the kernel tree
before the pcf8575 driver is removed ?

Bart.
