From: b32955@freescale.com (Huang Shijie)
Date: Wed, 26 Mar 2014 18:41:43 +0800
Subject: [PATCHv2 1/1] mtd: gpmi: make blockmark swapping optional
In-Reply-To: <20140326095156.3e5585b8@ipc1.ka-ro>
References: <532BCFCC.4080205@freescale.com>	<1395399017-19005-1-git-send-email-LW@KARO-electronics.de>	<20140324095902.GB11377@localhost>
 <20140326095156.3e5585b8@ipc1.ka-ro>
Message-ID: <5332AEE7.2040402@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2014?03?26? 16:51, Lothar Wa?mann ??:
> I don't see why this should not be supported on i.MX28 (i.MX23 doesn't
> do byteswapping anyway, so this wouldn't change anything for i.MX23).
> The partitions used by Linux need not necessarily be accessible for the
> Boot ROM code (and vice versa).
But the first partition used to store the u-boot is accessible for the ROM.

Please see "Figure 12-13" in the 12.12.1.12:
   "In order to preserve the BI (bad block information), flash updater 
or gang programmer
applications need to swap Bad Block Information (BI) data to byte 0 of 
metadata area for
every page before programming NAND Flash. ROM when loading firmware, 
copies back
the value at metadata[0] to BI offset in page data. The following figure 
shows how the
factory bad block marker is preserved."

So please the imx28 should _NOT_ support this feature.

thanks
Huang Shijie
