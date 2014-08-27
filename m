From: jlu@pengutronix.de (Jan =?ISO-8859-1?Q?L=FCbbe?=)
Date: Wed, 27 Aug 2014 11:55:44 +0200
Subject: [RESEND PATCH v2 1/4] irqchip: gic: Change irq type check when
 extension is present
In-Reply-To: <53F724F5.3040004@arm.com>
References: <1407895884-18131-1-git-send-email-srv_yingjoe.chen@mediatek.com>
 <1407895884-18131-2-git-send-email-srv_yingjoe.chen@mediatek.com>
 <53F724F5.3040004@arm.com>
Message-ID: <1409133344.25382.37.camel@coredoba.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc,

On Fri, 2014-08-22 at 12:09 +0100, Marc Zyngier wrote:
> Here, you're using it to program something that sits between the
> device and the GIC. This is a separate block, with its own hardware
> configuration, that modifies the interrupt signal. This should be
> reflected in the device-tree and the code paths.
> 
> You can probably model this as a separate irqchip for the few
> interrupts that require this, or have it configured at boot time
> (assuming the configuration never changes).

It seems to me that using a separate irqchip for a simple inverter would
add the run-time overhead of passing through wrapper functions on every
IRQ. Do you have an idea how this could be avoided without using the
gic_arch_extn feature?

As in the DT the actual IRQ polarity should be used, simply configuring
the HW IRQ polarity in the bootloader is not enough without telling the
GIC driver which polarity is supported on which IRQ, right?

Regards,
Jan
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
