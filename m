From: B32955@freescale.com (Huang Shijie-B32955)
Date: Thu, 30 Jun 2011 15:30:48 +0000
Subject: reply: [PATCH v7 0/3]  add the GPMI controller driver for IMX23/IMX28
Message-ID: <14C4E31473AF7E4B98176CB73615181C19FB66@039-SN1MPN1-006.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram:

Thanks for your hard work.

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
------------------------------------------------------------------------------------------------------
The log shows that it's a DMA failure.

I will debug it when i am free.

Best Regards
Huang Shijie


------------------------------------------------------------------------------------------------------

Regards,

   Wolfram

--
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
