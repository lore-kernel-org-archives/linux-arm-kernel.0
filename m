From: alberto.panizzo@gmail.com (Alberto Panizzo)
Date: Thu, 25 Feb 2010 10:31:29 +0100
Subject: [PATCH] MXC: mach_armadillo5x0: Add USB Host support.
In-Reply-To: <20100225080259.GA13295@pengutronix.de>
References: <1267054032.3870.47.camel@realization>
	<20100225080259.GA13295@pengutronix.de>
Message-ID: <1267090289.2722.4.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On gio, 2010-02-25 at 09:02 +0100, Uwe Kleine-K?nig wrote:
> Hi Alberto,
> 
> On Thu, Feb 25, 2010 at 12:27:12AM +0100, Alberto Panizzo wrote:
> > This add USB Host capability. The Armadillo 500 board is supplied
> > with two USB Host connectors driven by the USB OTG and USB Host 2
> > ports, through two NXP isp 1504 transceivers.
> > 
> > Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>
> > ---
> > 
> > Sascha, if there aren't problems, can you add this for 2.6.34?
> > 
..

> >  #include "crm_regs.h"
> > @@ -103,6 +108,118 @@ static int armadillo5x0_pins[] = {
> >  	/* I2C2 */
> >  	MX31_PIN_CSPI2_MOSI__SCL,
> >  	MX31_PIN_CSPI2_MISO__SDA,
> > +	/* OTG */
> > +	MX31_PIN_USBOTG_DATA0__USBOTG_DATA0,
> > +	MX31_PIN_USBOTG_DATA1__USBOTG_DATA1,
> > +	MX31_PIN_USBOTG_DATA2__USBOTG_DATA2,
> > +	MX31_PIN_USBOTG_DATA3__USBOTG_DATA3,
> > +	MX31_PIN_USBOTG_DATA4__USBOTG_DATA4,
> > +	MX31_PIN_USBOTG_DATA5__USBOTG_DATA5,
> > +	MX31_PIN_USBOTG_DATA6__USBOTG_DATA6,
> > +	MX31_PIN_USBOTG_DATA7__USBOTG_DATA7,
> > +	MX31_PIN_USBOTG_CLK__USBOTG_CLK,
> > +	MX31_PIN_USBOTG_DIR__USBOTG_DIR,
> > +	MX31_PIN_USBOTG_NXT__USBOTG_NXT,
> > +	MX31_PIN_USBOTG_STP__USBOTG_STP,
> > +	/* USB host 2 */
> > +	IOMUX_MODE(MX31_PIN_USBH2_CLK, IOMUX_CONFIG_FUNC),
> > +	IOMUX_MODE(MX31_PIN_USBH2_DIR, IOMUX_CONFIG_FUNC),
> > ...
> I think you need to protect all hunks by
> #ifdef CONFIG_USB_ULPI
> 
> For the pin-setup it's not important, but you must not call
> otg_ulpi_create if USB_ULPI isn't configured.
> 
> Best regards
> Uwe
> 

Ok, I'd seen this protection in pcm037 but I thought that on
my board USB will be always enabled.

Sascha, please throw this patch, The From: mail is wrong, sorry..

Alberto!
