From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 30 Oct 2009 18:07:54 +0100
Subject: At91SAM9G20 AT91_MCI patches
In-Reply-To: <5547BA931CA43849A16B2B02F2528D3938F80DD6@DEFTHW99E25MSX.ww902.siemens.net>
References: <5547BA931CA43849A16B2B02F2528D3938F80DD6@DEFTHW99E25MSX.ww902.siemens.net>
Message-ID: <4AEB1D6A.9030606@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Retallack, Mark :
> Good morning, I hope this is the correct list. 
> 
> I am using the AT91SAM9G20-EK dev board. It does not look like the vanilla kernel (2.6.27+) contains the patch for support in the drivers/mmc/host/at91_mci.c file. Patch 5130/3 contains the correct information, however the final patch 5130/4 has the at91_mci section removed. Was there a reason for this? 
> 
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=5130/3
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=5130/4

I advice you to go with Linux4sam.org experimental patches for 2.6.27.
for 2.6.30 you have a preview here:
ftp://ftp.linux4sam.org/devel/linux/
(pick the 3 ones that are at91_mci related)

> Also it would be useful to know what the preferred MCI (MMC) driver for the AT91SAM9G20 is; the at91_mci or atmel_mci. The revision A and B AT91SAM9G20-EK dev board (board-sam9g20ek.c) uses the at91_mci driver, but the revision C AT91SAM9G20-EK dev board (board-sam9g20ek-2slot-mmc.c) uses atmel_mci driver.

Dual slot 9g20 has a patch to enable at91_mci use:
http://lists.infradead.org/pipermail/linux-arm-kernel/2009-October/002577.html

- atmel_mci allow the use of 2 slots but does not handle PDC (DMA data
transfers)
- at91_mci is using PDC (recommended with experimental patches mentioned
above)

Best regards,
-- 
Nicolas Ferre
