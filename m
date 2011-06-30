From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 30 Jun 2011 12:40:09 +0200
Subject: [PATCH v7 0/3]  add the GPMI controller driver for IMX23/IMX28
In-Reply-To: <1309335878-16678-1-git-send-email-b32955@freescale.com>
References: <1309335878-16678-1-git-send-email-b32955@freescale.com>
Message-ID: <20110630104009.GC1997@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2011 at 04:24:35PM +0800, Huang Shijie wrote:
> The general-purpose media interface(GPMI) controller is a flexible interface
> to up to several NAND flashs.
> 
> The Bose Ray-Choudhury Hocquenghem(BCH) module is a hardware ECC accelerator.
> 
> With the help of BCH, the GPMI controller can choose to do the hardware ECC or
> not.
> 
> This driver is a _pure_ MTD NAND controller driver now.

It seems writing does not work for me. I use a MX28EVK, NAND is reported as:

[    1.670000] NAND device: Manufacturer ID: 0x2c, Chip ID: 0xdc (Micron MT29F4G08ABADAWP)

With ubiformat or the mtd_stresstest-module, I get stuff like this:

root at device:~ ubiformat /dev/mtd0
ubiformat: mtd0 (nand), size 536870912 bytes (512.0 MiB), 4096 eraseblocks of 131072 bytes (128.0 KiB), min. I/O size 2048 bytes
libscan: scanning eraseblock 4095 -- 100 % complete  
ubiformat: 4094 eraseblocks are supposedly empty
ubiformat: 2 bad eraseblocks found, numbers: 1243, 3935
ubiformat: formatting eraseblock 2 --  0 % complete  
[  172.430000] [ start_dma_without_bch_irq : 393 ] DMA timeout!!!
[  173.430000] [ start_dma_with_bch_irq : 424 ] bch timeout!!!
[  173.430000] [ mil_ecc_write_page : 1647 ] Error in ECC-based write: -110
[  173.440000] [ send_command : 305 ] step 1 error
[  173.440000] [ mil_cmd_ctrl : 1369 ] Chip: 0, Error -1
[  173.450000] [ send_command : 305 ] step 1 error
[  173.450000] [ mil_cmd_ctrl : 1369 ] Chip: 0, Error -1
[  173.460000] [ read_data : 386 ] step 1 error
...

Reading works though, mtd_readtest passes. Wild guess: something wrong
with the safe timings, perhaps?

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110630/391f685e/attachment.sig>
