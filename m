From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 18 Mar 2014 09:04:43 +0100
Subject: [PATCH v2 3/5] net: cpsw: Add control-module macid driver
In-Reply-To: <20140317171136.GC30471@atomide.com>
References: <1394888864-11007-1-git-send-email-mpa@pengutronix.de>
 <1394888864-11007-4-git-send-email-mpa@pengutronix.de>
 <20140317171136.GC30471@atomide.com>
Message-ID: <20140318080443.GH11360@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Mar 17, 2014 at 10:11:36AM -0700, Tony Lindgren wrote:
> Hi,
> 
> * Markus Pargmann <mpa@pengutronix.de> [140315 06:12]:
> > This driver extracts the hardware macid from the control module of
> > am335x processors. It exports a function cpsw_ctrl_macid_read for cpsw
> > to get the macid from within the processor.
> 
> Few things have improved recently :) This can be now implemented
> in a much cleaner way using regmap against the already defined syscon
> node.
> 
> For an example, see how the MMC PBIAS regulator is using regmap
> in Linux next:
> 
> 11469e0bb1 (regulator: add pbias regulator support)
> cd042fe5c1 (ARM: dts: add pbias dt node)
> 
> That avoids the problem of the tinkering with SoC specific registers
> that belong to another device.
> 
> So please update this series for regmap, let's not add more mapping
> of system control module registers to the drivers.

Thanks, I will have a look into this and update the series.

Regards,

Markus

> 
> Regards,
> 
> Tony
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140318/fa76d622/attachment.sig>
