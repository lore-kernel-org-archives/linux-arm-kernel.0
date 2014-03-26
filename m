From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Wed, 26 Mar 2014 12:55:02 +0100
Subject: [PATCHv2 1/1] mtd: gpmi: make blockmark swapping optional
In-Reply-To: <5332AEE7.2040402@freescale.com>
References: <532BCFCC.4080205@freescale.com>
 <1395399017-19005-1-git-send-email-LW@KARO-electronics.de>
 <20140324095902.GB11377@localhost>
 <20140326095156.3e5585b8@ipc1.ka-ro>
 <5332AEE7.2040402@freescale.com>
Message-ID: <20140326125502.0e8d0657@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Huang Shijie wrote:
> ? 2014?03?26? 16:51, Lothar Wa?mann ??:
> > I don't see why this should not be supported on i.MX28 (i.MX23 doesn't
> > do byteswapping anyway, so this wouldn't change anything for i.MX23).
> > The partitions used by Linux need not necessarily be accessible for the
> > Boot ROM code (and vice versa).
> But the first partition used to store the u-boot is accessible for the ROM.
> 
Whether this partition is available to Linux depends on the partition table
passed in the DT.

> Please see "Figure 12-13" in the 12.12.1.12:
>    "In order to preserve the BI (bad block information), flash updater 
> or gang programmer
> applications need to swap Bad Block Information (BI) data to byte 0 of 
> metadata area for
> every page before programming NAND Flash. ROM when loading firmware, 
> copies back
> the value at metadata[0] to BI offset in page data. The following figure 
> shows how the
> factory bad block marker is preserved."
> 
The inspection of the BB markers is only a fallback for the case that
there is no DBBT. From the same chapter that you quoted above:
| ROM uses DBBT to skip any bad block that falls within firmware data
| on NAND Flash device.
| If the address of DBBT Search Area in FCB is 0, ROM will rely on
| factory marked bad block markers to find out if a block is good or bad.

Thus, even the boot ROM of i.MX28 can well live without blockmark
swapping.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
