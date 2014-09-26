From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 26 Sep 2014 07:32:55 +0200
Subject: [PATCH v2 4/4] ARM: dts: mt8135: Add pinctrl node for mt8135.
In-Reply-To: <20140924124044.GC4992@pengutronix.de>
References: <1411443545-24951-1-git-send-email-srv_hongzhou.yang@mediatek.com>
 <1411443545-24951-5-git-send-email-srv_hongzhou.yang@mediatek.com>
 <CACRpkda-K7w-bY0uSdnZvzEKEeQg38oExoHPSW61kEv9Wv20mA@mail.gmail.com>
 <20140924124044.GC4992@pengutronix.de>
Message-ID: <20140926053255.GL4992@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

On Wed, Sep 24, 2014 at 02:40:44PM +0200, Sascha Hauer wrote:
> > I haven't got to reviewing the driver, but this looks just wrong.
> > 
> > Have the magic numbers in the driver.
> > 
> > Use strings to describe functions, not integers.
> 
> Interrupts, clocks, gpios, dma channels, nearly everything in the device tree is
> arbitrarily numbered. Instead of "irq-i2c0" we have <0 36 IRQ_TYPE_LEVEL_HIGH>
> in the device tree. These numbers can be resolved efficiently in the
> driver by shifting them to get a bitmask or by adding them as offset to
> a register base.
> Why do you want to make pinctrl different? Thanks to the recently
> introduced defines in the device trees these numbers are not magic at
> all anymore.

Any opinions on this?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
