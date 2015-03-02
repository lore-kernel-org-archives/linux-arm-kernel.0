From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 2 Mar 2015 20:12:01 +0100
Subject: [PATCH v5 1/6] mfd: fsl imx25 Touchscreen ADC driver
In-Reply-To: <20150217191438.GF19388@pengutronix.de>
References: <1422108103-15052-1-git-send-email-mpa@pengutronix.de>
 <1422108103-15052-2-git-send-email-mpa@pengutronix.de>
 <20150217191438.GF19388@pengutronix.de>
Message-ID: <20150302191201.GA26884@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Feb 17, 2015 at 08:14:38PM +0100, Uwe Kleine-K?nig wrote:
> Hello Markus,
> 
> On Sat, Jan 24, 2015 at 03:01:38PM +0100, Markus Pargmann wrote:
> > +config MFD_MX25_TSADC
> > +	tristate "Freescale i.MX25 integrated Touchscreen and ADC unit"
> > +	select REGMAP_MMIO
> > +	depends on SOC_IMX25
> Can you make that:
> 
> 	depends on SOC_IMX25 || COMPILE_TEST
> 
> ?

Yes, changed.

> 
> > + * The code contained herein is licensed under the GNU General Public
> > + * License. You may obtain a copy of the GNU General Public License
> > + * Version 2 or later at the following locations:
> Which version of the GPL is your code licensed under?

GPLv2 as described by MODULE_LICENSE. Will change the header
accordingly.

> 
> > +static int mx25_tsadc_setup_irq(struct platform_device *pdev,
> > +				struct mx25_tsadc *tsadc)
> > [...]
> > +	irq_set_chained_handler(irq, mx25_tsadc_irq_handler);
> > +	irq_set_handler_data(irq, tsadc);
> Do you need to reverse the order of these two calls to prevent the
> handler being called while handler_data is still unset?

Yes that's probably better although the subdevices which may cause
interrupts here are not populated at this point.

Thanks,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150302/29932a84/attachment.sig>
