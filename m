From: b32955@freescale.com (Huang Shijie)
Date: Fri, 22 Jul 2011 11:30:41 +0800
Subject: [PATCH v8 0/3] add the GPMI controller driver for IMX23/IMX28
In-Reply-To: <20110721215020.GA25344@pengutronix.de>
References: <1311230846-26437-1-git-send-email-b32955@freescale.com>
	<20110721215020.GA25344@pengutronix.de>
Message-ID: <4E28EEE1.2050008@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
>> The general-purpose media interface(GPMI) controller is a flexible interface
>> to up to several NAND flashs.
> ...
>> To Walfram & Artem:
>>     About how to disable the JFFS2 to use the OOB:
>>     I read the code, and I still have no idea about how to use the ecclayout
>>     to do the job. Could you give me some hint? thanks.
> Have you checked mxc_nand.c for example? There is
>
> static struct nand_ecclayout nandv1_hw_eccoob_smallpage = {
>         .eccbytes = 5,
>         .eccpos = {6, 7, 8, 9, 10},
>         .oobfree = {{0, 5}, {12, 4}, }
> }
>
> defined as one layout. Now, you could define one where oobfree is empty and
> eccbytes as big as the oob-area.
>
thanks. I will check the code.
>> The driver depends on another GPMI-NAND device patch set, you can find them at :
>> 	[1] http://lists.infradead.org/pipermail/linux-mtd/2011-July/037033.html
>> 	[2] http://lists.infradead.org/pipermail/linux-mtd/2011-July/037031.html
>> 	[3] http://lists.infradead.org/pipermail/linux-mtd/2011-July/037032.html
>> 	[4] http://lists.infradead.org/pipermail/linux-mtd/2011-July/037034.html
>>
>> The driver also depends on another DMA patch by Shawn:
>> 	[0] http://lists.infradead.org/pipermail/linux-mtd/2011-June/036820.html
> This makes it difficult for testers/reviewers. Please try to get a git-branch
> from Freescale or Linaro.
>
Shawn will merge my patches to his Linaro branch.

>> 	[4] DMA timeout issue. I use the .config created by `make mxs_defconfig`
>> 	    and the bug never occur. It seems some other module has impact to the
>> 	    DMA.
> Sadly, I can't confirm that. DMA timeout happens with my config as well as with
> the mxs_defconfig. ubiformat breaks immediately when trying to write.
Please check the attachment:
[1] my_config is my tested .config file, you can test it.
[2] a.sh is my testing shell script which also tests the ubiformat.

Best Regards
Huang Shijie


> Problem is that I am away from my dev-machine for a few days. I can do limited
> tests remotely but not develop actively right now. But if you need logs...
>
> Thanks,
>
>    Wolfram
>

-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: my_config
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110722/0317e8b2/attachment-0001.ksh>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: a.sh
Type: application/x-sh
Size: 347 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110722/0317e8b2/attachment-0001.sh>
