From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 18 Nov 2010 11:02:09 +0100
Subject: Zipit/uboot mmc driver issue
In-Reply-To: <AANLkTi=aySbiD=f3f5yHwDr0cNCwbC3M+ThLE-+E1a9a@mail.gmail.com>
References: <AANLkTi=aySbiD=f3f5yHwDr0cNCwbC3M+ThLE-+E1a9a@mail.gmail.com>
Message-ID: <201011181102.09286.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 November 2010 10:26:49 Phip wrote:
> Greetings,
> 
> I am having difficulties with the Zipit mmc driver and my SDHC card. I
> realize this may be an imposition; I write to you because I am trying to
> determine if the problem is with the mmc driver or elsewhere. I was not
> having any problems with SD card I/O under blob; this began when I flashed
> to u-boot.

Blob doesn't support SD/MMC at all. You mean linux kernel ?
> 
> dmesg comes to mounting root:
> 
> pxa-rtc pxa-rtc: setting system clock to 2000-01-01 00:00:18 UTC
> Waiting 2sec before mounting root device...
> mmc0: host does not support reading read-only switch. assuming
> write-enable. mmc0: new SDHC card at address 1234
> PM: Adding info for mmc:mmc0:1234
> mmcblk0: mmc0:1234 SA04G 2.68 GiB

The card is mis-detected ?
> 
> Then a few cycles of write errors like these:
> 
> mmcblk0: error -84 transferring data, sector 243, r 8, card status 0xe00
> end_request: I/O error, dev mmcblk0, sector 243
> Buffer I/O error on device mmcblk0p1, logical block 0
> lost page write due to I/O error on mmcblk0p1
> 
> And finally EXT3-fs detects a problem with the journal and remounts the
> filesystem read-only.
> 
> I do not mean to ask you to troubleshoot me, but it seems like you would be
> the best person to ask about this particular combination of hardware and
> software. Or perhaps there is a better place for me to ask?

CCing linux-arm-kernel
> 
> Thank you very much for your time
> Phip
> 
> - Zipit running u-boot 8/23/2010; 2.6.35 8/22/2010; both from mozzwald
> - SD card is a Kensington 4GB microSD in a miniSD adapter; works flawlessly
> on my desktop box.

Maybe the adapter is faulty, try another one. It happened a lot before.
