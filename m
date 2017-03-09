From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 9 Mar 2017 08:21:30 +0100
Subject: i.MX7 pinctrl driver writing to non existent registers
In-Reply-To: <20170308135751.GB19934@x250>
References: <20170208090817.omm2dydhqukdzgqy@pengutronix.de>
 <20170308135751.GB19934@x250>
Message-ID: <20170309072130.sdb6dbqvwyxn6idh@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 08, 2017 at 02:57:53PM +0100, Shawn Guo wrote:
> On Wed, Feb 08, 2017 at 10:08:17AM +0100, Sascha Hauer wrote:
> > Hi All,
> > 
> > The i.MX7 has two pinmux controllers, the LPSR and the regular one. We
> > instantiate a driver for each one. Now the driver assumes that the pins
> > are completely configured with one iomux controller, but for the LPSR
> > pins this is not true: The MUX_CTL and PAD_CTL registers are indeed
> > in the LPSR controller, but the SELECT_INPUT registers for the same
> > pin are found in the regular controller.
> > 
> > The result is that with this pin for example:
> > 
> > #define MX7D_PAD_GPIO1_IO06__UART5_DCE_RX                         0x0018 0x0048 0x0714 0x3 0x4
> > 
> > The LPSR controller writes to LPSR_BASE + 0x714 where it should really
> > be IOMUX_BASE + 0x714.
> 
> Isn't property fsl,input-sel being there for addressing that?

Indeed, I have overlooked that. Sorry for the noise.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
