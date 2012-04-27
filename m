From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 27 Apr 2012 09:30:48 +0200
Subject: [PATCH v3 2/4] pinctrl: pinctrl-imx: add imx pinctrl core driver
In-Reply-To: <20120426144446.GN9142@game.jcrosoft.org>
References: <1335451227-27709-1-git-send-email-b29396@freescale.com>
 <1335451227-27709-2-git-send-email-b29396@freescale.com>
 <20120426144446.GN9142@game.jcrosoft.org>
Message-ID: <20120427073048.GR17184@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2012 at 04:44:46PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > +			fsl,pins = <1386 0x17059	/* MX6Q_PAD_SD4_CMD__USDHC4_CMD */
> > +				    1392 0x17059	/* MX6Q_PAD_SD4_CLK__USDHC4_CLK	*/
> > +				    1462 0x17059	/* MX6Q_PAD_SD4_DAT0__USDHC4_DAT0 */
> > +				    1470 0x17059	/* MX6Q_PAD_SD4_DAT1__USDHC4_DAT1 */
> > +				    1478 0x17059	/* MX6Q_PAD_SD4_DAT2__USDHC4_DAT2 */
> > +				    1486 0x17059	/* MX6Q_PAD_SD4_DAT3__USDHC4_DAT3 */
> > +				    1493 0x17059	/* MX6Q_PAD_SD4_DAT4__USDHC4_DAT4 */
> > +				    1501 0x17059	/* MX6Q_PAD_SD4_DAT5__USDHC4_DAT5 */
> > +				    1509 0x17059	/* MX6Q_PAD_SD4_DAT6__USDHC4_DAT6 */
> > +				    1517 0x17059>;	/* MX6Q_PAD_SD4_DAT7__USDHC4_DAT7 */
> honestly I don't like this it's obscure need to decode manually
> 
> I propose to use phandle
> 
> as example on uart you will want or not the rst/cts so you will have quite a
> lot of bindings
> 
> so you can describe the pin configuration (function) and refer it by phandle
> in the group

I don't exactly know where are you aiming at. I think that you want a
collection of pin groups somewhere and want to refer to it in the device
nodes. No, please don't. There's no way to come up with a common group
needed for example for the IPU (image processing unit). What pins you
want to use here depends on the number of data lines you have on your
panel and what type of panel you have. You can always use the remaining
pins for somethin else. SPI is another example. The SPI unit has some
dedicated chip select lines. The exact number of used chip selects is
board specific.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
