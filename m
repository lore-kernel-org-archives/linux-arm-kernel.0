From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 9 Mar 2015 10:24:41 +0100
Subject: [PATCH v7 0/8] imx25 adc and touchscreen driver
In-Reply-To: <54FB4249.6070801@kernel.org>
References: <1425369498-25541-1-git-send-email-mpa@pengutronix.de>
 <54FB4249.6070801@kernel.org>
Message-ID: <20150309092441.GC3632@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 07, 2015 at 06:24:09PM +0000, Jonathan Cameron wrote:
> On 03/03/15 07:58, Markus Pargmann wrote:
> > Hi,
> > 
> > This series adds a driver for the Freescale i.MX25 SoC internal ADC unit which
> > is used for touchscreen and ADC. The driver consists of three parts, the MFD
> > driver which handles interrupts and some central configuration registers, the
> > ADC driver and the touchscreen driver.
> > 
> > v7 has some modifications in the probe functions to use devres irq requests.
> > irq checks were fixed to check for irqs <= 0. The header was cleaned up to have
> > a more uniform presentation of the bit fields. Detailed changelogs are attached
> > to the according mails.
> > 
> > Best Regards,
> > 
> > Markus
> Almost there as far as I am concerned.  Just that one unbalanced regulator_enable
> that needs dealing with.  The bindings are pretty simple so whilst a device-tree
> ack would of course be great I guess it could be taken without.
> 
> This wants to go via mfd or I suppose the freescale/arm-soc tree.  Either is fine
> with me.

Thanks for your review. I will fix the missing parts.

Best Regards,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150309/91c54f79/attachment.sig>
