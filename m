From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 22 Jun 2011 00:19:30 +0200
Subject: [PATCH 3/6] ARM: mach-imx/mx27_3ds: Add LCD support
In-Reply-To: <BANLkTinmCVrMLEfPR5BwAOStHbR2faO=Lg@mail.gmail.com>
References: <1308588522-16586-1-git-send-email-fabio.estevam@freescale.com>
	<1308588522-16586-2-git-send-email-fabio.estevam@freescale.com>
	<1308588522-16586-3-git-send-email-fabio.estevam@freescale.com>
	<20110621121105.GZ23771@pengutronix.de>
	<BANLkTimWSxWcpO=z69eqruyZkt7CMo9x2Q@mail.gmail.com>
	<BANLkTinmCVrMLEfPR5BwAOStHbR2faO=Lg@mail.gmail.com>
Message-ID: <20110621221930.GB6069@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2011 at 10:57:14AM -0300, Fabio Estevam wrote:
> Hi Sascha,
> 
> On Tue, Jun 21, 2011 at 9:59 AM, Fabio Estevam <festevam@gmail.com> wrote:
> > Hi Sascha,
> >
> > On Tue, Jun 21, 2011 at 9:11 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > ...
> >>> ? ? ? mxc_gpio_mode(SPI2_SS0 | GPIO_GPIO | GPIO_OUT);
> >>> ? ? ? mxc_gpio_mode(PMIC_INT | GPIO_GPIO | GPIO_IN);
> >>> + ? ? mxc_gpio_mode(SPI1_SS0 | GPIO_GPIO | GPIO_OUT);
> >>> + ? ? mxc_gpio_mode(LCD_ENABLE | GPIO_GPIO | GPIO_OUT);
> >>> + ? ? mxc_gpio_mode(LCD_RESET | GPIO_GPIO | GPIO_OUT);
> >>
> >> You can add these to the static pin array instead.
> >
> > I tried that initially and it caused all the gpio_request calls to fail.
> >
> > The only way I could make gpio_request to work is when I define the
> > pin as gpio mode via mxc_gpio_mode.
> 
> 
> I managed to put these definitions in the static pin array as you suggested.
> 
> In order to do so, I had to fix iomux-v1.c. I will send a v2 version
> including the iomux-v1 fix.
> 
> Please let me know if you have any other comments in the other patches
> so that I can consider them for v2.

The other patches look fine.

Sascha

> 
> Thanks,
> 
> Fabio Estevam
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
