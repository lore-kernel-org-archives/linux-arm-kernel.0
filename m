From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 1 Jul 2013 15:03:43 +0200
Subject: [v2 4/4] sata: imx: add ahci sata support on imx platforms
In-Reply-To: <51D17AF1.2060504@gmail.com>
References: <1372672975-2997-1-git-send-email-r65037@freescale.com>
 <1372672975-2997-5-git-send-email-r65037@freescale.com>
 <51D17AF1.2060504@gmail.com>
Message-ID: <20130701130343.GY516@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 01, 2013 at 07:49:53AM -0500, Rob Herring wrote:
> On 07/01/2013 05:02 AM, Richard Zhu wrote:
> > imx6q contains one Synopsys AHCI SATA controller,
> > But it can't shares ahci_platform driver with other
> > controllers.
> > Because there are some misalignments of the bits
> > definitions of the HBA registers and the Vendor
> > Specific registers
> >  - CAP_SSS(bit20) of the HOST_CAP is writable, default
> >  value is '0', should be configured to be '1'
> >  - bit0 (only one AHCI SATA port on imx6q) of the
> >  HOST_PORTS_IMPL should be set to be '1'.(default 0)
> >  - One Vendor Specific register HOST_TIMER1MS(offset:0xe0)
> >  should be configured regarding to the frequency of AHB
> >  bus clock.
> 
> All this really belongs in the bootloader.

I beg to differ. Normally we do not write the kernel that it depends on
setup being done by the bootloader.

> Wouldn't you most likely be
> booting the kernel from SATA as well?

Having a SATA disk attached doesn't mean you boot from it.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
