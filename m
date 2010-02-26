From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Fri, 26 Feb 2010 11:33:53 +0100
Subject: [PATCH] mx31pdk: Add NAND support
In-Reply-To: <201002261056.37618.jbe@pengutronix.de>
References: <210155.75899.qm@web51001.mail.re2.yahoo.com>
	<201002261056.37618.jbe@pengutronix.de>
Message-ID: <1267180433.2778.56.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ven, 2010-02-26 at 10:56 +0100, Juergen Beisert wrote:
> Fabio Estevam wrote:
> > > Are you sure that this works? Don't you see a lot of Bad
> > > blocks reports
> > > in boot messages?
> >
> > I followed the same approach used on other i.MX boards. This is what I see:
> > ...
> > NAND device: Manufacturer ID: 0xec, Chip ID: 0xaa (Samsung NAND 256MiB 1,8V
> > 8-bit) Scanning device for bad blocks
> > Bad eraseblock 42 at 0x000000540000
> > Bad eraseblock 125 at 0x000000fa0000
> > Bad eraseblock 887 at 0x000006ee0000
> > Bad eraseblock 1750 at 0x00000dac0000
> > Bad eraseblock 2046 at 0x00000ffc0000
> > Bad eraseblock 2047 at 0x00000ffe0000
> > Registering mxc_nand as whole device
> >
> > If I define it as:
> >
> > static struct mxc_nand_platform_data mx31pdk_nand_board_info = {
> > 	.width = 1,
> > 	.hw_ecc = 1,
> > 	.flash_bbt =1,
> > };
> 
> Your bootloader also use a Bad Block Table? Then also your kernel should use 
> it. If hardware ECC is in use, its always a good idea to collect the bad 
> blocks into a BBT. Most of the time you can't control at which offset in the 
> OOB data the NAND controller will store the ECC sum. There is the risk it 
> will destroy manufacturer's bad block markers. So, its better to collect 
> these marked bad blocks into a BBT the first time you use the NAND device. 
> After that _only_ the BBT should be used to handle bad blocks (in the boot 
> loader and the kernel).
> 
> jbe
> 
Thank you Juergen to participate on this thread.
Ok, so with this board shall be enabled the flash_bbt checking because 
the bootloader uses it. But how do you explain that on Mine board the 
kernel recognize it correctly and in Fabio's board the kernel prompt 
disagree with the bootloader one? It is a kind of bootloader issue?

-- 
Alberto!

        Be Persistent!
                - Greg Kroah-Hartman (FOSDEM 2010)
