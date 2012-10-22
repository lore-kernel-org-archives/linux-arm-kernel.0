From: b-cousson@ti.com (Benoit Cousson)
Date: Mon, 22 Oct 2012 14:27:20 +0200
Subject: [PATCH 5/8] i2c: omap: introduce and use OMAP_I2C_IP_VERSION_3
In-Reply-To: <1350899218-13624-6-git-send-email-balbi@ti.com>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
 <1350899218-13624-6-git-send-email-balbi@ti.com>
Message-ID: <50853BA8.8000200@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

On 10/22/2012 11:46 AM, Felipe Balbi wrote:
> on OMAP4+ we want to read IRQSTATUS_RAW register,
> instead of IRQSTATUS. The reason being that IRQSTATUS
> will only contain the bits which were enabled on
> IRQENABLE_SET and that will break when we need to
> poll for a certain bit which wasn't enabled as an
> IRQ source.
> 
> One such case is after we finish converting to
> deferred stop bit, we will have to poll for ARDY
> bit before returning control for the client driver
> in order to prevent us from trying to start a
> transfer on a bus which is already busy.
> 
> Note, however, that omap-i2c.c needs a big rework
> on register definition and register access. Such
> work will be done in a separate series of patches.

Do you need OMAP_I2C_IP_VERSION_3 for OMAP4?

OMAP_I2C_IP_VERSION_2 was already introduced to detect OMAP3630 vs
omap4430 because they were sharing the same IP version..

/* I2C controller revisions present on specific hardware */
#define OMAP_I2C_REV_ON_2430            0x36
#define OMAP_I2C_REV_ON_3430_3530       0x3C
#define OMAP_I2C_REV_ON_3630_4430       0x40

So in theory you should not need an extra version.

Regards,
Benoit
