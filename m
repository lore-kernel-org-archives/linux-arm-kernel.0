From: pj0585@gmail.com (Prasant J)
Date: Wed, 24 Aug 2011 11:28:24 +0530
Subject: Issues with atmel-mci when using SDHC (Linux 3.0.3)
Message-ID: <CAA2DH4vCRny5-ffWWTfw54e15Tzu7FOT-eR03BW5PBhSpWagpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm working on a custom board design based on AT91SAM9G45-EKES. I'm
using Linux 3.0.3
My root filesystem (ext3) is on SDHC card (on mmc0) which is being
used in the non-SPI mode.
My root partition size is approximately 1.5GB. This works fine.

I want to increase the size of my root partition (say, to 3GB).
Whenever I increase the size of the rot filesystem, I get this error
message while booting:
mmcblk0: retrying using single block read (printed in the file
drivers/mmc/host/atmel-mci.c) and booting fails.

When I probe, I see that in the data transfer operations return error
-110 (brq.data.error).

Is atmel-mci limited to certain partition size? Can anyone point out
what may be wrong?

-Prasant J
