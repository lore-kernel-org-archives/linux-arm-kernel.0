From: b32955@freescale.com (Huang Shijie)
Date: Tue, 9 Aug 2011 18:41:09 +0800
Subject: GPMI-NAND Status?
In-Reply-To: <20110809091906.GA1923@pengutronix.de>
References: <20110805135133.GA26981@pengutronix.de>
	<4E3FA88E.4070804@freescale.com>
	<20110809091906.GA1923@pengutronix.de>
Message-ID: <4E410EC5.8080600@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
> Hi,
>
>>> ecclayout needs to be used to show that OOB is fully in use [1]
>>> ===============================================================
>>>
>>> Needed to make it work for JFFS2 and to pass the mtd-testsuite. A driver only
>>> working with UBIFS is surely not ready for mainline.
>>>
>> It seems just modifying the ecclayout of GPMI-NAND can not fix the problem.
>> It should also change the code of JFFS2 and mtd.
>>
>> Some one ever posted a patch about this:
>> http://lists.infradead.org/pipermail/linux-mtd/2007-December/020047.html
> This mail is about MLC. That's another issue. For SLC, ecclayout should
> work, no?

The matter is that the GPMI/BCH will use the OOB. Please see the page 1263
in 16.2.2 of mx28's datasheet. It shows an NAND PAGE's layout.

You may see that the OOB will be used for storing the DATA or ECC.
There will be left some space even when i enable the BCH,  it seems the 
left space can
contains the jffs2's clean marker.  It needs to be confirmed. :)

thanks
Huang Shijie

> Regards,
>
>     Wolfram
>
