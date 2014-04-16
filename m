From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 16 Apr 2014 14:41:02 +0800
Subject: [PATCH] ARM: dts: imx27-pdk: Add PMIC support
In-Reply-To: <1397630251.213119658@f389.i.mail.ru>
References: <1397598912-5464-1-git-send-email-festevam@gmail.com>
 <1397630251.213119658@f389.i.mail.ru>
Message-ID: <20140416064100.GI2523@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 10:37:31AM +0400, Alexander Shiyan wrote:
> Tue, 15 Apr 2014 18:55:12 -0300 ?? Fabio Estevam <festevam@gmail.com>:
> > From: Fabio Estevam <fabio.estevam@freescale.com>
> > 
> > imx27-pdk has a MC13783 PMIC connected to CSPI2 port.
> > 
> > Add support for it.
> > 
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> > ---
> ...
> >  &iomuxc {
> >  	imx27-pdk {
> > +		pinctrl_cspi2: cspi2grp {
> > +			fsl,pins = <
> > +				MX27_PAD_CSPI2_MISO__CSPI2_MISO 0x0
> > +				MX27_PAD_CSPI2_MOSI__CSPI2_MOSI 0x0
> > +				MX27_PAD_CSPI2_SCLK__CSPI2_SCLK 0x0
> > +				MX27_PAD_CSPI2_SS0__GPIO4_21	0x0 /* SPI2 CS0 */
> > +				MX27_PAD_TOUT__GPIO3_14		0x0 /* PMIC IRQ */
> > +			>;
> > +		};
> 
> IRQ GPIO should be in a separate pingroup for PMIC.

Right, patch dropped.

Shawn
