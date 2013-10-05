From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 5 Oct 2013 18:11:47 +0800
Subject: IMX6 USDHC card detection
In-Reply-To: <20131005093527.GU12758@n2100.arm.linux.org.uk>
References: <20131003193623.GF12758@n2100.arm.linux.org.uk>
 <CAOMZO5DrdXpWuULubSjSw7fhCm40JiXnVZwu=YMjzX1sW_tuuw@mail.gmail.com>
 <20131005092000.GL2734@S2101-09.ap.freescale.net>
 <20131005093527.GU12758@n2100.arm.linux.org.uk>
Message-ID: <20131005101145.GM2734@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 05, 2013 at 10:35:27AM +0100, Russell King - ARM Linux wrote:
> On Sat, Oct 05, 2013 at 05:20:01PM +0800, Shawn Guo wrote:
> > DATA3 as Card Detection Pin:
> > If this bit is set, DATA3 should be pulled down to act as a card
> > detection pin. Be cautious when using this feature, because DATA3 is
> > also a chip-select for the SPI mode. A pull-down on this pin and CMD0
> > may set the card into the SPI mode, which the uSDHC does not support.
> 
> The issue there is if the pull-down is too strong.
> 
> DATA3 is pulled up by the SD card via a 50k internal resistor.  If the
> IMX6 is programmed to pull down via 100k, that will result in 2/3s of
> the card supply on DATA3.  That should be fine given the card thresholds:
> 
> 				Min		Max
> Input High Voltage	VIH	0.625*VDD	VDD+0.3		V
> Input Low Voltage	VIL	VSS-0.3		0.25*VDD	V
> 
> Of course, if a board has an additional external pull-down resistor on
> DAT3, that will lower the DATA3 voltage level, so that's where a problem
> could be.
> 
> Would you be happy if I added new pinctrl entries to imx6qdl.dtsi which
> pulled down the DATA3 line - that way, existing DT setups will not be
> affected, and they can switch over if they wish to using controller
> based card detection.

I'm fine with it.

Shawn
