From: tony@atomide.com (Tony Lindgren)
Date: Wed, 21 Oct 2015 16:41:34 -0700
Subject: MUSB peripheral DMA regression caused by driver core runtime PM change
Message-ID: <20151021234134.GQ3078@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I noticed a regresssino in v4.3-rc series to day with MUSB gadgets
and DMA. Doing a git bisect between v4.2..v4.3-rc1 on it pointed to:

ddef08dd00f5 ("Driver core: wakeup the parent device before trying probe")

With the commit above reverted things work fine with DMA and USB gadgets.

This is on omap3 with CONFIG_USB_INVENTRA_DMA selected. Selecting
CONFIG_MUSB_PIO_ONLY still works even without reverting ddef08dd00f5.

Anybody got ideas what might be wrong? Some wrong runtime PM usage
under drivers/usb/musb?

Regards,

Tony
